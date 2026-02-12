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

: 'copy dotfile to home directory' ; (
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

: 'copy .config dir to home direcotry' ; (
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

: 'create zsh autoload (completion) dir' ; (
	ZSH_AUTOLOAD_PATH="${HOME}/.local/share/zsh/functions"
	if [[ ! -d ${ZSH_AUTOLOAD_PATH} ]]; then
		mkdir -p ${ZSH_AUTOLOAD_PATH}
		log "create ${ZSH_AUTOLOAD_PATH}"
	else
		log "skip ${ZSH_AUTOLOAD_PATH} already exists."
	fi
)


: 'set up user functions' ; {
	# dev projects
	if [[ ! -d ~/.local/share/dev-projects ]]; then
		mkdir -p ~/.local/share/dev-projects
	fi

	if [[ ! -f ~/.local/share/dev-projects/dev ]]; then
		touch ~/.local/share/dev-projects/dev
	fi
}
