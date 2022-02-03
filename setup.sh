#!/bin/zsh

DOTFILE_DIR=$(cd "$(dirname "$0")" && pwd)

# --- functions

log() {
	echo "$@"
} >&2

# --- copy dotfile
for DOTFILE_PATH in ${DOTFILE_DIR}/dots/*; do
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

# --- copy config
if [[ ! -d ${HOME}/.config ]]; then
	mkdir ${HOME}/.config
fi

for CONFIG_PATH in ${DOTFILE_DIR}/config/*; do
	SRC=${CONFIG_PATH}
	DST=${HOME}/.config/$(basename "$CONFIG_PATH")

	if [[ -L $DST ]]; then
		rm "${DST}" && log "${DST} is symbolic link, remove it."
	elif [[ -e $DST ]]; then
		mv "${DST}" "${DST}.org" && log "${DST} already exists, rename it."
	fi

	ln -s "${SRC}" "${DST}"
done
