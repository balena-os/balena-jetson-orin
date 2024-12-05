FILESEXTRAPATHS:append := ":${THISDIR}/${PN}"

SRC_URI += "  \
    file://enable_80211d.patch \
"
