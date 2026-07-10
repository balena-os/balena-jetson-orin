FILESEXTRAPATHS:append := ":${THISDIR}/files"

# Increase scan duration and make sure caches are flushed
# to overcome autokit sporadic scan reporting.
SRC_URI:append:imx8mm-var-dart = " \
    file://0005-scan_len.patch \
"
