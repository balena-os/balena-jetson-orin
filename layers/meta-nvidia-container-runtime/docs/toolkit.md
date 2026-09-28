# Toolkit sourcing and the CVE floor

## Where the NVIDIA container recipes come from

`nvidia-container-toolkit` and `libnvidia-container` come from **meta-tegra**, at
whatever version the consuming device repo's meta-tegra pin ships (1.19.1 on the
wrynose pin used today). They are not vendored here — vendoring means maintaining
a fork, and the extension should always match its BSP.

They need help to be visible at all. meta-tegra keeps them under
`external/virtualization-layer/`, and its own `layer.conf` only adds that directory
to `BBFILES` when a layer collection named `virtualization-layer` (i.e.
meta-virtualization) is in `BBFILE_COLLECTIONS`. balena device repos do not carry
meta-virtualization, so without help the recipes are invisible and
`nvidia-container-toolkit` fails to resolve.

`conf/layer.conf` therefore adds the two recipes explicitly:

```
BBFILES += "${LAYERDIR}/../meta-tegra/external/virtualization-layer/recipes-containers/nvidia-container-toolkit/nvidia-container-toolkit_*.bb"
BBFILES += "${LAYERDIR}/../meta-tegra/external/virtualization-layer/recipes-containers/libnvidia-container/libnvidia-container_*.bb"
```

Two things about that:

- **`${LAYERDIR}/../meta-tegra` assumes meta-tegra is checked out alongside this
  layer under `layers/`** — the convention every balena device repo follows.
- **Two narrow globs, not one wide one.** A glob over `recipes-containers/` also
  picks up `docker/docker-moby_%.bbappend`, which itself requires
  meta-virtualization.

## `DISTRO_FEATURES`

`conf/layer.conf` appends `virtualization opengl`:

- **`virtualization`** — required by `nvidia-container-toolkit` and
  `libnvidia-container` (both set `REQUIRED_DISTRO_FEATURES = "virtualization"`).
- **`opengl`** — required by `tegra-libraries-camera` and `tegra-libraries-multimedia*`,
  which `drivers.csv` references for the V4L2 / camera / video pipelines.

`x11` stays disabled (balenaOS is headless) and `vulkan` stays disabled (not needed
for the CUDA-runtime payload).

This is why the extension needs its own build config rather than joining the
device repo's default template — see [integration.md](integration.md).

## The `docker` RDEPENDS

meta-tegra's toolkit recipe RDEPENDS on `docker`; balenaOS ships balena-engine.
Stripped in `nvidia-container-toolkit_%.bbappend`.

## CVE floor

Because the version follows meta-tegra rather than being pinned here, a meta-tegra
bump could walk the toolkit **backwards**. The legacy route runs through
`nvidia-container-cli`, which is exactly where the known CVEs live:

| CVE | Fixed in |
|---|---|
| [CVE-2024-0132](https://nvidia.custhelp.com/app/answers/detail/a_id/5616) | 1.16.2 (incompletely) |
| [CVE-2025-23359](https://github.com/advisories/GHSA-vmg3-7v43-9g23) (the 0132 bypass) | 1.17.4 |
| [CVE-2025-23266 / CVE-2025-23267](https://nvidia.custhelp.com/app/answers/detail/a_id/5659) ("NVIDIAScape") | 1.17.8 |

`nvidia-container-toolkit_%.bbappend` asserts **>= 1.17.8** and fails the build
below it.

**If you hit that assertion, move meta-tegra forward — do not lower the floor.**

## The `libnvmm_jpeg.so` CSV entry

`recipes-bsp/tegra-binaries/tegra-configs_%.bbappend` appends one line to
meta-tegra's `drivers.csv`:

```
lib, /usr/lib/libnvmm_jpeg.so
```

Without it `libgstnvarguscamerasrc.so` will not load inside a container, so
`nvarguscamerasrc` fails and camera capture is impossible.

Two upstream notes, both worth raising with OE4T:

- The entry is simply **missing from meta-tegra's `drivers.csv`** on r39.2.0.
- A sibling CSV file cannot be used instead: `mount-spec-path` is a directory, but
  **only `drivers.csv` and `devices.csv` are read** — it is not globbed. Verified
  on-device by repointing `mount-spec-path` at a writable copy.

The bbappend is defensive: it `bbfatal`s if the CSV is missing (meta-tegra
restructured) and `bbnote`s "drop this bbappend" if the entry has appeared
upstream.
