# Integrating into a device repo

## 1. Add the submodule

```sh
git submodule add https://github.com/balena-os/meta-nvidia-container-runtime.git \
    layers/meta-nvidia-container-runtime
```

It **must** sit under `layers/`, alongside `layers/meta-tegra` — `conf/layer.conf`
reaches `${LAYERDIR}/../meta-tegra/` to pick up the NVIDIA container recipes. See
[toolkit.md](toolkit.md).

## 2. Add it to the device repo's bblayers template

balena-yocto-scripts builds the hostapp and every extension in one bitbake
invocation, with one configuration. Add the layer to the device repo's
`conf/templates/default/bblayers.conf.sample`:

```
    ${TOPDIR}/../layers/meta-nvidia-container-runtime \
```

The layer leaves the base OS image unchanged. It does not change
`DISTRO_FEATURES` or the build's Go version, and it modifies no recipe the base
image installs. See [toolkit.md](toolkit.md#distro_features) for how it does that.

## 3. Add the extension to the machine's hostapp composition

In `<machine>.hostapp.yml`:

```yaml
services:
  nvidia-runtime:
    image: __BUILD_OUTPUT__
    network_mode: none
    runtime: extension
    labels:
      io.balena.image.class: 'overlay'
      io.balena.image.override: '200'
    profiles:
      - nvidia          # optional; omit to ship on every device
    x-build:
      recipe: balena-nvidia-runtime
```

- `network_mode: none` stops compose-go from injecting a `default` network. The
  supervisor would create a bridge for it, and its subnet can collide with the
  device LAN.
- `runtime: extension` routes the container to the extension runtime.
- `labels` must agree with the labels the recipe stamps at import. See
  [design.md](design.md#image-labels).

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

The hostApp deploy also needs a balena CLI whose compose parser accepts
`runtime:`. Pull request runs build but skip the deploy job; only `push` and
`workflow_dispatch` runs deploy.

## Minimum meta-balena

meta-balena v9.1.0, which this layer targets. Pins that predate the extension
work lack `HOSTAPP_EXTENSION_REMOVE_PATHS` and the `IMAGE_FSTYPES` the class needs
to produce a tarball, so `do_create_docker_image` fails.

## Building locally

From the device repo, with the layer in the default template:

```sh
./balena-yocto-scripts/build/balena-build.sh \
    -d <machine> -s <shared-dir> -i balena-nvidia-runtime -k
```

Pass `-k` or `balena-build.sh` deletes the helper image at the end and the next
run re-pulls 1.5 GB.

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
