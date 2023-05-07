#!/usr/bin/bash


TOOL_EXEC=latexmk
TMP_DIR_NAME=ztmp_latex
TEX_FILE_PATH=$1


if [[ -z "${TEX_FILE_PATH}" ]]; then
    echo "Missing 1st argument: TEX_FILE_PATH"
    exit 1
fi
if [[ ! -f "${TEX_FILE_PATH}" ]]; then
    echo "${TEX_FILE_PATH} is not a file"
    exit 1
fi
if [[ "${TEX_FILE_PATH}" != *.tex ]]; then
    echo "${TEX_FILE_PATH} is not a tex file"
    exit 1
fi


TEX_FILE_PATH="$(readlink -f "${TEX_FILE_PATH}")"
TEX_DIR_PATH="$(dirname -- "${TEX_FILE_PATH}")"
TEX_FILE_NAME_NOEXT=$(basename -- "$TEX_FILE_PATH")
TEX_FILE_NAME_NOEXT="${TEX_FILE_NAME_NOEXT%.*}"

TMP_DIR_PATH="${TEX_DIR_PATH}/${TMP_DIR_NAME}"
TMP_PDF_PATH="${TMP_DIR_PATH}/${TEX_FILE_NAME_NOEXT}.pdf"

OUT_PDF_PATH="${TEX_DIR_PATH}/${TEX_FILE_NAME_NOEXT}.pdf"


echo "TEX_DIR_PATH: ${TEX_DIR_PATH}"
echo "TEX_FILE_NAME_NOEXT: ${TEX_FILE_NAME_NOEXT}"
echo "TMP_PDF_PATH: ${TMP_PDF_PATH}"
echo "OUT_PDF_PATH: ${OUT_PDF_PATH}"
echo
echo "Press Enter to progress"
read -s -n 1 key


"${TOOL_EXEC}" -synctex=1 -interaction=nonstopmode -file-line-error -pdf -outdir="${TMP_DIR_PATH}" "${TEX_FILE_PATH}"


if [[ -f "${TMP_PDF_PATH}" ]]; then
    cp "${TMP_PDF_PATH}" "${OUT_PDF_PATH}"
fi
