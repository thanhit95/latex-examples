# LATEX SIMPLE TUTORIALS WITH EXAMPLES

## Brief

This repository provides simple tutorials (mostly examples) for learning LaTeX. Additionally, I support some scripts to make it easier to work on a local machine.

The tutorials are presented in a logical and streamlined manner to help you maximize your learning.

## Usage in local machine

Note: Scripts are supported only in Linux environments.

### Build

To build (compile) a TEX file into a PDF file:

```shell
build.sh tex_file_name

# Example:
build.sh 01-basis.tex
```

The output PDF file:

- Shall have the same name as the TEX file
- Shall be placed in the same directory as the TEX file

### Cleanup

```shell
cleanup.sh
```

The cleanup script shall automatically identify the files that will be removed and shall show you a list of those files before proceeding.

Output example:

```text
$ ./cleanup.sh

TEX_DIR_PATH: /home/me/latex-tut

pdf files to be removed:
/home/me/latex-tut/01-basis.pdf
/home/me/latex-tut/02-sections.pdf

directory to be removed: /home/me/latex-tut/ztmp_latex
directory to be removed: /home/me/latex-tut/svg-inkscape

Press Enter to proceed
...
Finish
```

## Author

Author: Thanh Nguyen

- Email: thanh.it1995@gmail.com
- Facebook: <https://www.facebook.com/thanh.it95>
