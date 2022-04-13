#!/bin/bash
#
# TBD.

binary_is_valid() {
  local -r BINARY_PATH="${1}"
  local -r BINARY_NAME="$(basename "${BINARY_PATH}")"
  local -r BINARY_DIR="$(dirname "${BINARY_PATH}")"
  local -r SUM_FILE="${BINARY_NAME}.sha256sum"
  local BINARY_VERSION
  local SUM_SRC
  local SUM_FILE
  local -i SHA256SUM_EXIT_STATUS

  case "${BINARY_NAME}" in
    "terraform")
      BINARY_VERSION="$(basename "${BINARY_DIR//'v'/''}")"
      SUM_SRC="https://releases.hashicorp.com/terraform/${BINARY_VERSION}/terraform_${BINARY_VERSION}_SHA256SUMS"
      SUM_FILE="$(basename "${SUM_SRC}")"

      wget -q -P "${BINARY_DIR}" "${SUM_SRC}"
      grep "${BINARY_PATH}" "${BIN_FILE_SUM}" > "${SUM_FILE}"
      sha256sum -c "${SUM_FILE}"
      SHA256SUM_EXIT_STATUS=$?
    ;;
  esac
}
