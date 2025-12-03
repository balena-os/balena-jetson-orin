# Force single-threaded build for nss-native to avoid race conditions
# with Hacl cryptography library object linking
PARALLEL_MAKE:class-native = "-j 1"
