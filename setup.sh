#!/bin/zsh -eu

WORKING_DIR=$(cd "$(dirname "$0")" && pwd)

function log() {
	echo "$@"
} >&2

function changed() {
	# yellow color
	log "[0;33mchanged:[m $*"
}

function warn() {
	# red color
	log "[0;31mwarn:[m $*"
}

function skip() {
	# green color
	log "[0;32mskip:[m $*"
}

function section() {
	# cyan color
	log "[0;36m$*[m"
}

function isSynLinked() {
	local SRC=$1
	local DST=$2
	if [[ -L ${DST} && $(readlink ${DST}) = ${SRC} ]]; then
		return 0
	else
		return 1
	fi
}


section "Step 1 -- deploy dotfiles to home directory"; (
	for SRC in ${WORKING_DIR}/dots/*; do
		DST=${HOME}/.$(basename ${SRC})

		if isSynLinked $SRC $DST; then
			skip "create symlink ${DST##$HOME/}"
			continue
		fi

		if [[ -e $DST ]]; then
			mv ${DST} ${DST}.org
			warn "${DST##$HOME/} exists, rename to ${DST##*/}.org"
		fi

		ln -s ${SRC} ${DST}
		changed "create symlink ${DST##$HOME/}"
	done
)

section 'Step 2 -- deploy XDG configs to ~/.config' ; (
	if [[ ! -d ~/.config ]]; then
		mkdir ~/.config
	fi

	for SRC in ${WORKING_DIR}/config/*; do
		DST=${HOME}/.config/$(basename ${SRC})

		if isSynLinked $SRC $DST; then
			skip "create symlink ${DST##$HOME/}"
			continue
		fi

		if [[ -e $DST ]]; then
			mv ${DST} ${DST}.org
			warn "${DST##$HOME/} exists, rename to ${DST##*/}.org"
		fi

		ln -s ${SRC} ${DST}
		changed "create symlink ${DST##$HOME/}"
	done
)

section 'Step 3 -- create custom zsh autoload directory' ; {
	ZSH_AUTOLOAD_PATH="${HOME}/.local/share/zsh/functions"
	if [[ ! -d ${ZSH_AUTOLOAD_PATH} ]]; then
		mkdir -p ${ZSH_AUTOLOAD_PATH}
		changed "create directory ${ZSH_AUTOLOAD_PATH##$HOME/}"
	else
		skip "create directory ${ZSH_AUTOLOAD_PATH##$HOME/}"
	fi
}


section 'Step 4 -- set up dev-projects tool' ; {
	# dev projects dir
	DEV_PROJECTS_DIR="${HOME}/.local/share/dev-projects"
	if [[ ! -d ${DEV_PROJECTS_DIR} ]]; then
		mkdir -p ${DEV_PROJECTS_DIR}
		changed "create directory ${DEV_PROJECTS_DIR##$HOME/}"
	else
		skip "create directory ${DEV_PROJECTS_DIR##$HOME/}"
	fi

	DEV_PROJECTS_LIST="${DEV_PROJECTS_DIR}/dev"
	if [[ ! -f ${DEV_PROJECTS_LIST} ]]; then
		touch ${DEV_PROJECTS_LIST}
		changed "create file ${DEV_PROJECTS_LIST##$HOME/}"
	else
		skip "create file ${DEV_PROJECTS_LIST##$HOME/}"
	fi
}
