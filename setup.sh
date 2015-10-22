#!/bin/bash

SCRIPT_FILE=${0##*/}
DOTFILE_RELATIVE_DIR=$(dirname "$0")
DOTFILE_DIR=$(cd "$DOTFILE_RELATIVE_DIR"; pwd)


# --- functions

log() {
	echo "$@"
} >&2

# --- copy dotfile
for DOTFILE_PATH in ${DOTFILE_DIR}/*; do
	DOTFILE_NAME=$(basename "$DOTFILE_PATH")

	if [ "$DOTFILE_NAME" = "$SCRIPT_FILE" ]; then
		continue
	fi

	FILE_SRC=${DOTFILE_PATH}
	FILE_DST=${HOME}/.${DOTFILE_NAME}

	if [ -L "$FILE_DST" ]; then
		rm "$FILE_DST" && log "${FILE_DST} is symbolic link, remove it."

	elif [ -e "$FILE_DST" ]; then
		mv "$FILE_DST" "$FILE_DST.org" && log "${FILE_DST} already exists, rename it."
	fi

	ln -s "$FILE_SRC" "$FILE_DST"
done


# --- install vundle.vim

cd "${DOTFILE_DIR}"
git submodule init
git submodule update

