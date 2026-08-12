# Integrating into a device repo

## 1. Add the submodule

```sh
git submodule add https://github.com/balena-os/meta-nvidia-container-runtime.git \
    layers/meta-nvidia-container-runtime
```

It **must** sit under `layers/`, alongside `layers/meta-tegra` — `conf/layer.conf`
reaches `${LAYERDIR}/../meta-tegra/` to pick up the NVIDIA container recipes. See
[toolkit.md](toolkit.md).

## 2. Do *not* add it to the device repo's default bblayers template

`conf/layer.conf` appends `virtualization opengl` to `DISTRO_FEATURES`.
`DISTRO_FEATURES` is global and feeds every recipe's signature, so putting this
layer in the device repo's default template would change what the **base OS image**
builds, not just the extension.

Instead the extension gets its own build config, shipped here at
`conf/templates/wrynose/`, selected per-service in step 3. The device repo's
default template is left alone.

Two constraints shaped that layout, both from `barys`:

- A relative `-t` path **must start with `layers/`**, so the template has to live
  under a layer.
- `barys`' default (no `-t`) discovery globs `layers/meta-balena-*/` for a single
  `bblayers.conf.sample`. Putting a second template under the device repo's
  `meta-balena-<bsp>` layer makes that glob ambiguous and breaks the plain hostapp
  build.

The template names meta-balena's series layer and the oe-core layout explicitly,
but resolves the device repo's BSP integration layer (`meta-balena-jetson`,
`meta-balena-thor`, …) **by glob**, so it is not tied to one device-type repo. Keep
it in sync with the device repo's own
`conf/templates/default/bblayers.conf.sample`.

## 3. Add the extension to the machine's hostapp composition

In `<machine>.hostapp.yml`:

```yaml
services:
  nvidia-runtime:
    image: __BUILD_OUTPUT__
    profiles:
      - nvidia          # optional; omit to ship on every device
    x-build:
      recipe: balena-nvidia-runtime
      build_args:
        - "-t"
        - "layers/meta-nvidia-container-runtime/conf/templates/wrynose"
```

The `io.balena.image.*` labels are stamped by the recipe through
`balena-hostapp-extension.bbclass`, so they do **not** belong in the compose file.

Behind a compose `profiles:` entry, a fleet opts in after provisioning rather than
every device carrying a ~600 MB extension it may not want. The pipeline treats
`profiles` as pass-through; activation is a POST to `/resin/application_profile`
with `activates__profile_name: nvidia`.

Do not copy the PoC's `kernel-modules: {x-build: ~}` opt-out unless the meta-balena
pin in use actually declares a `kernel-modules` service. Under the current
composition spec a service with `x-build: ~` and no concrete `image:` fails
validation.

## 4. Point CI at an extensions-capable workflow

The reusable `yocto-build-deploy.yml` must be one that builds `x-build` services
from `${MACHINE}.hostapp.yml`. See the
[hostapp-composition spec](https://github.com/balena-os/balena-yocto-scripts/blob/master/docs/specs/hostapp-composition.md).

Dispatch with `-f force-finalize=true`. Without it the `Upload-hostapp-artifacts`
step is skipped and `Deploy-to-S3` then fails late downloading the missing bundle.

## Minimum meta-balena

`balena-hostapp-extension.bbclass` must exist and support
`HOSTAPP_EXTENSION_REMOVE_PATHS`. Without the class setting `IMAGE_FSTYPES` no
tarball is produced and `do_create_docker_image` fails.

## Building locally

From the device repo:

```sh
./balena-yocto-scripts/build/balena-build.sh \
    -d <machine> -s <shared-dir> -i balena-nvidia-runtime -k \
    -g "-b build-ext -t layers/meta-nvidia-container-runtime/conf/templates/wrynose"
```

Use a **separate build dir** (`-b`) so the base OS build and the extension build do
not thrash one `TMPDIR` between two `DISTRO_FEATURES` sets. Pass `-k` or
`balena-build.sh` deletes the helper image at the end and the next run re-pulls
1.5 GB.

Artifacts land in `<build-dir>/tmp/deploy/images/<machine>/`:

- `balena-nvidia-runtime-<machine>.tar.gz` — the extension rootfs
- `balena-nvidia-runtime-<machine>.docker` — the labelled, importable image

## Adapting to another Tegra SoC

The layer is SoC-neutral. meta-tegra handles the split internally for everything
installed here — `tegra-libraries-cuda` selects `CUDA_DRV_VARIANT` (`nvgpu` vs
`openrm`) by `SOC_FAMILY`, `tegra-firmware` has separate `-tegra234`/`-tegra264`
packages, and the rest are `COMPATIBLE_MACHINE = "(tegra)"` or ungated.
`drivers.csv`/`devices.csv` are a shared superset already listing both the nvgpu
(`/dev/nvhost-*`) and RM (`/dev/nvidia*`) device nodes; libnvidia-container skips
paths that do not exist.

What genuinely needs re-testing on new silicon:

1. **`mode=csv` may be wrong on an open-RM SoC (e.g. Thor).** It is forced because
   `auto` resolves to NVML and never reads the CSVs. On open-RM the NVML route is
   arguably the intended one — but the Tegra multimedia and camera libraries only
   arrive via CSV.
2. **Camera** — different ISP, different NITO tuning files, and the
   `libnvmm_jpeg.so` CSV gap may not be present.
3. **CUDA arch** — the acceptance container must carry kernels for the target
   `TEGRA_CUDA_ARCHITECTURE`.
