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

The extension builds in the same bitbake invocation and configuration as the base
OS, so this layer must not change `DISTRO_FEATURES`. `DISTRO_FEATURES` feeds most
recipes' signatures, and adding a feature would change the base OS image.

The recipes the extension installs gate on two features the base OS lacks:

- **`virtualization`**: `nvidia-container-toolkit` and `libnvidia-container`.
- **`opengl`**: `tegra-libraries-camera`, `tegra-libraries-multimedia*`,
  `tegra-argus-daemon`, and the EGL provider `libglvnd` with its
  `l4t-nvidia-glheaders` dependency.

In these recipes the feature is only a `features_check` gate. No recipe changes
what it builds based on it: meta-tegra tests neither feature anywhere else, and
meta-tegra's `libglvnd` bbappend sets `PACKAGECONFIG:tegra` explicitly. So
`conf/layer.conf` removes the gate per recipe with
`REQUIRED_DISTRO_FEATURES:remove:pn-<recipe>`. The base image installs none of
these recipes.

A gated dependency missing from that list fails at parse time with "missing
required distro feature", naming the recipe. Add it to the list.

`x11` and `vulkan` stay disabled.

## Go toolchain

`nvidia-container-toolkit` 1.19.1 declares `go 1.25.0` in `go.mod`. meta-balena
pins the build's Go to 1.24.6 (`GOVERSION` in `balena-os.inc`) for balena-engine,
and one bitbake configuration has one `go-cross`. Raising it would rebuild the
base OS with a different compiler.

So the toolkit alone builds with a private toolchain:

- `nvruntime-go-native` reuses oe-core's `go-binary-native` recipe for the upstream
  binary and its checksums. It provides nothing and stages under
  `${libdir}/${NVRUNTIME_GOROOT_DIR}`, so the build's Go selection is unchanged.
- `nvidia-container-toolkit_%.bbappend` replaces the `go-cross` and `go-runtime`
  dependencies with it and points `GOROOT`, `GO` and `GOTOOLDIR` at it. Upstream
  Go cross-compiles the standard library itself, and cgo uses the recipe's `CC`.
  `GOTOOLCHAIN=local` stops Go from fetching another toolchain.

`libnvidia-container` declares `go 1.17` and builds with the build's Go.

When oe-core moves past 1.26.4, rename `nvruntime-go-native_1.26.4.bb` to match.
Its `require` fails until you do.

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
| [CVE-2026-24260](https://github.com/NVIDIA/product-security/blob/main/2026/5850/5850.md) (TOCTOU, component not stated) | 1.19.1 |

`nvidia-container-toolkit_%.bbappend` asserts **>= 1.19.1** and fails the build
below it.

**If you hit that assertion, move meta-tegra forward — do not lower the floor.**

## The `libnvmm_jpeg.so` CSV entry

`add_missing_csv_entry` in `balena-nvidia-runtime.bb` appends one line to
meta-tegra's `drivers.csv` in the extension rootfs:

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

It patches the image rootfs, not the `tegra-configs` recipe, because the base
image installs other `tegra-configs` packages. A recipe change would change the
base OS.

The function is defensive: it `bbfatal`s if the CSV is missing (meta-tegra
restructured) and `bbnote`s "drop add_missing_csv_entry" if the entry has appeared
upstream.
