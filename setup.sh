#!/bin/zsh -eu

WORKING_DIR=$(cd "$(dirname "$0")" && pwd)

function log() {
	echo "$@"
} >&2

function isSynLinked() {
	local SRC=$1
	local DST=$2
	if [[ -L ${DST} ]] && [[ $(readlink ${DST}) = ${SRC} ]]; then
		return 0
	else
		return 1
	fi
}

: copy dotfile to home directory ; (
	for SRC in ${WORKING_DIR}/dots/*; do
		DST=${HOME}/.$(basename ${SRC})

		if isSynLinked $SRC $DST; then
			log "skip ${DST} has already been created."
			continue
		elif [[ -e $DST ]]; then
			mv ${DST} ${DST}.org && log "${DST} exists, rename it."
		fi

		ln -s ${SRC} ${DST} && log "create ${DST}"
	done
)

: copy commands to ~/apps/bin ; (
	if [[ ! -d ~/apps/bin ]]; then
		mkdir -p ~/apps/bin
	fi

	for SRC in ${WORKING_DIR}/bin/*; do
		DST=${HOME}/apps/bin/$(basename ${SRC})

		if isSynLinked $SRC $DST; then
			log "skip ${DST} has already been created."
			continue
		elif [[ -e $DST ]]; then
			mv ${DST} ${DST}.org && log "${DST} exists, rename it."
		fi

		ln -s ${SRC} ${DST} && log "create ${DST}"
	done
)

: copy .config dir to home direcotry ; (
	if [[ ! -d ~/.config ]]; then
		mkdir ~/.config
	fi

	for SRC in ${WORKING_DIR}/config/*; do
		DST=${HOME}/.config/$(basename ${SRC})

		if isSynLinked $SRC $DST; then
			log "skip ${DST} has already been created."
			continue
		elif [[ -e $DST ]]; then
			mv ${DST} ${DST}.org && log "${DST} exists, rename it."
		fi

		ln -s ${SRC} ${DST} && log "create ${DST}"
	done
)

: copy nvim setting ; (
	NVIM_AUTOLOAD_PATH="${HOME}/.local/share/nvim/site/autoload"
	mkdir -p ${NVIM_AUTOLOAD_PATH}

	SRC="${WORKING_DIR}/dots/vim/autoload/plug.vim"
	DST="${NVIM_AUTOLOAD_PATH}/plug.vim"

	if isSynLinked $SRC $DST; then
			log "skip ${DST} has already been created."
	else
		if [[ -e $DST ]]; then
			mv ${DST} ${DST}.org && log "${DST} exists, rename it."
		fi

		ln -s ${SRC} ${DST} && log "create ${DST}"
	fi
)

: sync vim setting with nvim setting ; (
	TARGETS=(after ftdetect ftplugin)
	for TARGET in ${TARGETS[@]}; do
		SRC=${WORKING_DIR}/dots/vim/${TARGET}
		DST=${HOME}/.config/nvim/

		DST_FILE=${DST}${TARGET}

		if isSynLinked ${SRC} ${DST_FILE}; then
			log "skip ${DST_FILE} has already been created."
			continue
		elif [[ -e $DST_FILE ]]; then
			mv ${DST_FILE} ${DST_FILE}.org && log "${DST_FILE} exists, rename it."
		fi

		ln -s ${SRC} ${DST} && log "create ${DST_FILE}"
	done
)


