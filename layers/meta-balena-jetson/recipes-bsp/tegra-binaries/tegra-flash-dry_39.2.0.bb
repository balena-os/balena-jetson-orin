FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

SUMMARY = "Deploy partition spec file"

LICENSE = "Apache-2.0"
LIC_FILES_CHKSUM = "file://${BALENA_COREBASE}/COPYING.Apache-2.0;md5=89aea4e17d99a7cacdbeed46a0096b10"

inherit deploy

# TODO: Update partition spec
PARTSPEC:jetson-agx-thor-devkit = "partition_specification234_agx_thor.txt"

BINARY_INSTALL_PATH = "/opt/tegra-binaries/"

SRC_URI = " \
    file://${PARTSPEC} \
"

do_install() {
    install -d ${D}/${BINARY_INSTALL_PATH}
    install ${UNPACKDIR}/${PARTSPEC} ${D}/${BINARY_INSTALL_PATH}/
}

do_deploy() {
    rm -rf ${DEPLOY_DIR_IMAGE}/$(basename ${BINARY_INSTALL_PATH}) || true
    mkdir -p ${DEPLOY_DIR_IMAGE}/$(basename ${BINARY_INSTALL_PATH})
    cp -r ${D}/${BINARY_INSTALL_PATH}/* ${DEPLOY_DIR_IMAGE}/$(basename ${BINARY_INSTALL_PATH})
}

FILES:${PN} += " \
    /opt/tegra-binaries/* \
"

do_configure(){
    :
}

do_compile(){
    :
}

INHIBIT_PACKAGE_STRIP = "1"
INHIBIT_PACKAGE_DEBUG_SPLIT = "1"

# need to be redeployed on each build
# as this path is not cached
do_install[nostamp] = "1"
do_deploy[nostamp] = "1"
do_unpack[nostamp] = "1"

addtask do_deploy before do_package after do_install
