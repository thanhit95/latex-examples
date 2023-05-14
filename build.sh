#!/usr/bin/bash


EXEC_TOOL=
TMP_DIR_NAME=ztmp_latex
TEX_FILE_PATH=$1


function detect_build_tool() {
    declare -a tool_names=( "latexmk" "pdflatex" "tectonic" )
    for tool_name in "${tool_names[@]}"; do
        tool_path="$(command -v "${tool_name}")"
        if [[ ! -z "${tool_path}" ]]; then
            echo "${tool_name}"
            return
        fi
    done
    echo ""
    return
}


function copy_tex_file_to_tmp_dir() {
    local tmp_dir_path="$1"
    local tex_file_path="$2"
    local tex_file_name=$(basename -- "${tex_file_path}")
    local tmp_tex_file_path="${tmp_dir_path}/${tex_file_name}"
    mkdir -p "${tmp_dir_path}"
    cp "${tex_file_path}" "${tmp_tex_file_path}"
    if [[ ! -f "${tmp_tex_file_path}" ]]; then
        echo ""
        return
    fi
    echo "${tmp_tex_file_path}"
}


EXEC_TOOL="$(detect_build_tool)"
echo "EXEC_TOOL: ${EXEC_TOOL}"
if [[ -z "${EXEC_TOOL}" ]]; then
    echo "Unable to find a tool to build"
    exit 1
fi


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
TEX_FILE_NAME_NOEXT=$(basename -- "${TEX_FILE_PATH}")
TEX_FILE_NAME_NOEXT="${TEX_FILE_NAME_NOEXT%.*}"

TMP_DIR_PATH="${TEX_DIR_PATH}/${TMP_DIR_NAME}"
TMP_PDF_PATH="${TMP_DIR_PATH}/${TEX_FILE_NAME_NOEXT}.pdf"

OUT_PDF_PATH="${TEX_DIR_PATH}/${TEX_FILE_NAME_NOEXT}.pdf"

tmp_text_file_path=


echo "TEX_DIR_PATH: ${TEX_DIR_PATH}"
echo "TEX_FILE_NAME_NOEXT: ${TEX_FILE_NAME_NOEXT}"
echo "TMP_PDF_PATH: ${TMP_PDF_PATH}"
echo "OUT_PDF_PATH: ${OUT_PDF_PATH}"
echo
echo "Press Enter to proceed"
read -s -n 1 key


case "${EXEC_TOOL}" in

    latexmk)
        "${EXEC_TOOL}" -synctex=1 -interaction=nonstopmode -file-line-error -pdf -outdir="${TMP_DIR_PATH}" "${TEX_FILE_PATH}"
        ;;

    pdflatex)
        tmp_text_file_path="$(copy_tex_file_to_tmp_dir "${TMP_DIR_PATH}" "${TEX_FILE_PATH}")"
        if [[ -z "${tmp_text_file_path}" ]]; then
            echo "Copy failure from ${TEX_FILE_PATH} to ${tmp_text_file_path}"
            exit 1
        fi
        (
            cd "${TMP_DIR_PATH}" && \
            exec "${EXEC_TOOL}" -synctex=1 -interaction=nonstopmode -file-line-error "${tmp_text_file_path}"
        )
        ;;

    tectonic)
        mkdir -p "${TMP_DIR_PATH}"
        "${EXEC_TOOL}" --synctex --keep-logs --outdir "${TMP_DIR_PATH}" "${TEX_FILE_PATH}"
        ;;

esac


if [[ -f "${TMP_PDF_PATH}" ]]; then
    cp "${TMP_PDF_PATH}" "${OUT_PDF_PATH}"
    echo
    echo "OUT_PDF_PATH: ${OUT_PDF_PATH}"
fi
