do_deploy() {
    cp ${B}/images/${EDK2_BIN_NAME} ${DEPLOY_DIR_IMAGE}/${EDK2_BIN_NAME}
}

do_deploy[nostamp] = "1"

