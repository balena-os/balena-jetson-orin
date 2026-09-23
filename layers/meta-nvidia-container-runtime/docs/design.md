# Design

## Scope: legacy route only

This layer ships the **legacy runtime route** — `runtime: nvidia` in compose,
`--runtime=nvidia` on the CLI. That is the route every NGC quickstart and every
pre-CDI tutorial uses, so the NGC catalogue works as-is.

**CDI is deliberately not shipped.** No `nvidia-ctk cdi generate`, no
`/run/cdi/nvidia.yaml`, no `features.cdi`, no `nvidia-cdi-hook` wiring, no
`devices: [nvidia.com/gpu=all]`. The PoC proved that route works; productising it
is a later cycle.

There is also **no supervisor dependency**. The extension configures balena-engine
directly; nothing here needs the compose `runtime:` field plumbed through the
supervisor. (A supervisor that forwards `runtime:` is what makes the route usable
from a compose file rather than from the host shell — tracked separately.)

## What ships in the extension

| Component | Source |
|---|---|
| L4T driver libraries, EGL/GLES subset, `tegra` symlink | meta-tegra (`tegra-libraries-*`) |
| `tegra-container-passthrough` tree, container CSVs, firmware, `nv_tegra_release` | meta-tegra |
| `nvargus-daemon` + camera libraries | meta-tegra (via `tegra-libraries-camera`) |
| `nvidia-container-runtime`, `nvidia-container-runtime-hook`, `nvidia-ctk` | meta-tegra `nvidia-container-toolkit` |
| `nvidia-container-cli`, `libnvidia-container.so*` | meta-tegra `libnvidia-container` |
| `balena-nvidia-setup` boot oneshot | this layer |

The BSP half resolves against whatever meta-tegra the consuming device repo pins,
so the extension always matches its BSP — including the toolkit. See
[toolkit.md](toolkit.md).

### Deliberately not installed

| Package | Why |
|---|---|
| `tegra-libraries-glxcore` | GLX is X11-only; balenaOS is headless |
| `tegra-libraries-vulkan` | not needed for the CUDA runtime payload |
| `tegra-libraries-multimedia-v4l` | V4L2 codec; the Orin Nano media block does not expose the nvenc/nvdec nodes |
| `tegra-libraries-omx` | legacy OpenMAX, deprecated upstream |
| `tegra-libraries-dla-compiler` | recipe dropped upstream in L4T r39 |

The camera payload ships (via `tegra-libraries-camera`'s RDEPENDS on
`tegra-argus-daemon`), keeping the payload monolithic so a later cycle does not
need a new image.

## The boot oneshot

`balena-nvidia-setup.service` runs once per boot, ordered
`After=bind-etc-docker.service nvidia-container-setup.service`,
`Before=balena.service`. Three steps, each guarding a specific failure:

**1. Poll for `/dev/nvidiactl` / `/dev/nvidia0`.** This has to be a poll — L4T
devnodes are kernel-direct devtmpfs entries and bypass udev, so a systemd
`.device` unit never activates. A timeout is a **warning, not a failure**: the
runtime is still installed correctly, and failing the unit would be worse than a
late devnode.

**2. Register the `nvidia` runtime** in `/etc/docker/daemon.json` via
`nvidia-ctk runtime configure`. Ordering after `bind-etc-docker.service` matters:
`/etc/docker` is a bind-mount from the data partition, and writing before it is in
place hits `EROFS`.

**3. Patch `/run/nvidia-container-runtime/config.toml`** with two settings:

- `nvidia-container-runtime.runtimes` gains `balena-runc`. balena-engine ships
  `balena-runc`, not `runc`, and without this the hook fails with
  `no runtime binary found from candidate list: [docker-runc runc crun]`.
- `nvidia-container-runtime.mode=csv`, **forced**. This is essential and not
  obvious: the default `auto` resolves to the NVML platform because we ship
  `libnvidia-ml`, and the NVML path never reads the CSVs at all. Without this
  nothing is mounted into any container. See
  [rootfs-assembly.md](rootfs-assembly.md#the-four-camera-fixes).

## Image labels

Set through `balena-hostapp-extension.bbclass` variables rather than hand-rolled
`--change` lines in the device repo's compose file, so the layer carries its own
install semantics and every consuming device repo gets them for free.

| Label | Value | Why |
|---|---|---|
| `io.balena.image.class` | `overlay` | |
| `io.balena.image.store` | `data` | |
| `io.balena.update.requires-reboot` | `1` | mobynit merges at boot |
| `io.balena.image.override` | `200` | opts into **shadowing**, not just extending — the payload lands libraries in paths the base OS also populates. Lower wins. |

`io.balena.image.os-version` is **not** set here; the bbclass stamps it from
`HOSTOS_VERSION`. See [os-version.md](os-version.md).

## Paths kept out of the strip list

`HOSTAPP_EXTENSION_REMOVE_PATHS` defaults to `"etc run var"`. This layer sets
`"run bin sbin"` — both directories dropped from the default are load bearing,
and **neither failure is visible at build or merge time**:

**`/etc`** holds the container mount spec that drives the whole extension:
`nvidia-container-runtime/host-files-for-container.d/{drivers,devices}.csv`, the
`config.toml` symlink, and `/etc/nv_tegra_release` (which the toolkit's own
platform detection keys off). Without it nothing is mounted into any container.

**`/var`** holds `/var/nvidia/nvcam/settings`, the ISP tuning data (`.nito` files)
installed by `tegra-libraries-camera`. Deleting it makes `nvargus-daemon` abort the
moment a client connects:

```
Cannot open directory '/var/nvidia/nvcam/settings'
listNitoFiles() returned empty list. No nitos found
double free or corruption (out)  -> SIGABRT
```

systemd then restarts it, so a container sees `Connection refused` on the Argus
socket and the cause looks like anything but a missing file. `/var` is not kept
wholesale — see [rootfs-assembly.md](rootfs-assembly.md#var-filtering).

`bin` and `sbin` are added to the list because a merged-usr rootfs leaves them as
symlinks this extension should not contribute.

## Kernel-override hooks

`kernel-override-hooks` is appended by the bbclass and deliberately left in place.
The hooks self-detect kernel content: with no `Module.symvers` under
`{usr/,}lib/modules/<ver>/`, `extension_detect_kernel_override` returns 1 and all
three exit 0.

Measured cost of keeping them: **+136 tar entries, +2.9 MB compressed**. 132 of
those already exist byte-identically in the host image (`bash`, `parted`, `mtools`,
`tune2fs`, `/etc/terminfo/*`), pulled in via `os-helpers-bootenv` →
`os-helpers-fs`; only `/hooks/{create,start,deactivate}` are new. The duplicates
cost nothing over the wire because delivery is a delta against the previous image,
and they shadow host paths with identical content.

An earlier revision removed them, justified by a PoC-era bug where `hooks/create`
misdetected the extension and blocked the install. That is no longer reachable.
