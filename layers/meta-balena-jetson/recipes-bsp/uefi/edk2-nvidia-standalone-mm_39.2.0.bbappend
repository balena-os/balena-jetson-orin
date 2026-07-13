FILESEXTRAPATHS:append := ":${THISDIR}/files"

SRC_URI:append = " \
    file://0001-StandaloneMmOptee-Don-t-assert-if-var-store-integrit.patch;patchdir=../edk2-nvidia \
"

do_deploy() {
    cp ${B}/images/${EDK2_BIN_NAME} ${DEPLOY_DIR_IMAGE}/${EDK2_BIN_NAME}
}

do_deploy[nostamp] = "1"

