# Series support

**wrynose only** (L4T r39.x / JetPack 7.x). `LAYERSERIES_COMPAT` declares nothing
else, and the layer carries no cross-series compatibility code — targeting one
series keeps it small and lets the NVIDIA container recipes be consumed straight
from meta-tegra rather than copied.

## Why scarthgap was removed rather than left half-done

Earlier scarthgap (L4T r36.x / JetPack 6.x) work was deleted deliberately. If it is
ever picked up, three things need solving and **only the first is in this layer's
control**:

**1. A device repo on scarthgap cannot ship extensions at all today.**
balena-jetson-orin master pins meta-balena `v7.8.1`, and
`balena-hostapp-extension.bbclass` first appears in `v7.9.0`. That bump is an
OS-team decision with its own v7.8→v7.9 fallout.

**2. The Go floor.** `nvidia-container-toolkit` >= 1.18.1 requires Go >= 1.25.0.
wrynose gets that from oe-core's 1.26.4 Go recipe set; scarthgap has only poky's
1.22.12 and meta-balena's pinned 1.24.6, so a Go recipe would have to be vendored.

**3. meta-tegra's NVIDIA recipes are written against wrynose's `go.bbclass`.**
scarthgap's version rewrites any git `SRC_URI` lacking a `destsuffix`, relocating
the tree to `<basename(S)>/src/<GO_IMPORT>/`. `libnvidia-container` sets neither
`destsuffix` nor `patchdir`, so its patch applies at the wrong level and `do_patch`
fails. `nvidia-container-toolkit` survives only because it happens to set both.

Point 3 is the one that shapes the decision: supporting another series means
genuinely **porting** the NVIDIA recipes, not copying them.

## Go version pins

`conf/templates/wrynose/local.conf.sample` carries four
`PREFERRED_VERSION_go-* = "1.26.4"` lines. All four are load bearing — meta-balena
vendors a complete parallel Go 1.24.6 recipe set, and the compiler that actually
runs comes from `go-cross` via `GOROOT`, not from the bootstrap. Trimming any of
them silently drops the build back to 1.24.6, below the toolkit's floor.
