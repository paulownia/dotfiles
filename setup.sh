#!/bin/zsh

DOTFILE_DIR=$(cd "$(dirname "$0")" && pwd)

# --- functions

log() {
	echo "$@"
} >&2

# --- copy dotfile
for DOTFILE_PATH in ${DOTFILE_DIR}/files/*; do
	DOTFILE_NAME=$(basename "${DOTFILE_PATH}")

	FILE_SRC=${DOTFILE_PATH}
	FILE_DST=${HOME}/.${DOTFILE_NAME}

	if [[ -L $FILE_DST ]]; then
		rm "${FILE_DST}" && log "${FILE_DST} is symbolic link, remove it."
	elif [[ -e $FILE_DST ]]; then
		mv "${FILE_DST}" "${FILE_DST}.org" && log "${FILE_DST} already exists, rename it."
	fi

	ln -s "${FILE_SRC}" "${FILE_DST}"
done

# --- copy commands
if [[ ! -d ~/apps/bin ]]; then
	mkdir -p ~/apps/bin
fi

for CMD_PATH in ${DOTFILE_DIR}/bin/*; do
	FILE_SRC=$CMD_PATH
	FILE_DST=${HOME}/apps/bin/$(basename "$CMD_PATH")

	if [[ -L $FILE_DST ]]; then
		rm "${FILE_DST}" && log "${FILE_DST} is symbolic link, remove it."
	elif [[ -e $FILE_DST ]]; then
		mv "${FILE_DST}" "${FILE_DST}.org" && log "${FILE_DST} already exists, rename it."
	fi

	ln -s "${FILE_SRC}" "${FILE_DST}"
done
