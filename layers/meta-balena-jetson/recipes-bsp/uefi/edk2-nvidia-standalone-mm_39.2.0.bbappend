FILESEXTRAPATHS:append := ":${THISDIR}/files"

SRC_URI:append = " \
    file://0001-StandaloneMmOptee-Don-t-assert-if-var-store-integrit.patch;patchdir=../edk2-nvidia \
    file://0001-Library-PlatformBm-Update-RootfsRetryCountMax-value.patch;patchdir=../edk2-nvidia \
    file://0001-L4TConfiguration-Switch-RootfsRetryCountMax-from-3-t.patch;patchdir=../edk2-nvidia \
"

do_deploy() {
    cp ${B}/images/${EDK2_BIN_NAME} ${DEPLOY_DIR_IMAGE}/${EDK2_BIN_NAME}
}

SOURCE_DATE_EPOCH = "${@int(time.time())}"

do_deploy[nostamp] = "1"
