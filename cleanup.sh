#!/usr/bin/bash


TEX_DIR_PATH="$(dirname "$(readlink -f "$0")")"

TMP_DIR_NAME=ztmp_latex
TMP_DIR_PATH="${TEX_DIR_PATH}/${TMP_DIR_NAME}"

TMP_DIR_NAME2=svg-inkscape
TMP_DIR_PATH2="${TEX_DIR_PATH}/${TMP_DIR_NAME2}"


echo "TEX_DIR_PATH: ${TEX_DIR_PATH}"
echo
echo "pdf files to be removed:"
find "${TEX_DIR_PATH}" -maxdepth 1 -mindepth 1 -type f -name "*.pdf" 2>/dev/null
echo
[[ -d "${TMP_DIR_PATH}" ]] && echo "directory to be removed: ${TMP_DIR_PATH}"
[[ -d "${TMP_DIR_PATH2}" ]] && echo "directory to be removed: ${TMP_DIR_PATH2}"
echo
echo "Press Enter to proceed"
read -s -n 1 key


[[ -d "${TMP_DIR_PATH}" ]] && rm -rf "${TMP_DIR_PATH}"
[[ -d "${TMP_DIR_PATH2}" ]] && rm -rf "${TMP_DIR_PATH2}"
# rm -f "${TEX_DIR_PATH}"/*.pdf
find "${TEX_DIR_PATH}" -maxdepth 1 -mindepth 1 -type f -name "*.pdf" -exec rm -f '{}' \; 2>/dev/null
