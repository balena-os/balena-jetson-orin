# meta-nvidia-container-runtime

A Yocto layer that builds a balenaOS **hostapp-extension** carrying the NVIDIA
container runtime stack for Tegra devices, so stock NGC containers run
**non-privileged** on a balena-managed device:

```sh
balena run --rm --runtime=nvidia nvcr.io/nvidia/cuda:13.1.1-runtime-ubuntu24.04 nvidia-smi
```

No `--privileged`, no `/usr/lib/aarch64-linux-gnu` host bind-mounts, no
per-application driver juggling, and no NVIDIA toolkit baked into the base OS
image.

The layer is device-type agnostic. Any NVIDIA device-type repo (balena-jetson-orin
today, Thor next) submodules it and builds the extension through its own CI.

## Status

Validated end to end on an Orin Nano Devkit NVMe, balenaOS 7.9.3 / JetPack 7.2:
CUDA acceptance (`nvidia-smi`, driver 595.78, CUDA 13.2) and IMX219 CSI capture
through Argus, both from stock NGC containers, non-privileged.

**wrynose only** (L4T r39.x / JetPack 7.x) — see [series support](docs/series-support.md).

**Legacy route only** — `--runtime=nvidia`. CDI is deliberately not shipped.

## Documentation

| | |
|---|---|
| [Design](docs/design.md) | scope, payload, boot oneshot, labels, what is kept and why |
| [Integration](docs/integration.md) | adding this layer to a device repo, building locally, other SoCs |
| [Toolkit & CVEs](docs/toolkit.md) | how the NVIDIA recipes are sourced from meta-tegra, the CVE floor |
| [Rootfs assembly](docs/rootfs-assembly.md) | what the image recipe's preprocess functions do, and the failures behind them |
| [`os-version` label](docs/os-version.md) | why the extension does not set it |
| [Series support](docs/series-support.md) | wrynose only, and what scarthgap would need |
| [Troubleshooting](docs/troubleshooting.md) | diagnosing a silent non-merge, GPU-less containers, camera failures |

## Layout

```
conf/layer.conf                     DISTRO_FEATURES, meta-tegra recipe exposure
conf/templates/wrynose/             build config for the extension (not the base OS)
recipes-core/images/                the extension image recipe
recipes-support/balena-nvidia-setup/  boot oneshot
recipes-bsp/tegra-binaries/         drivers.csv fix
recipes-containers/                 toolkit bbappend (docker RDEPENDS, CVE floor)
```

## Licence

This layer's own recipes and scripts are MIT — see [`COPYING.MIT`](COPYING.MIT).
The NVIDIA container recipes consumed from meta-tegra carry their own upstream
licence metadata, and the L4T binary payload they package is governed by NVIDIA's
own licence terms.

Redistribution of the L4T libraries and the toolkit is subject to **NVIDIA
licensing review — that review gates public release** of images built from this
layer.
