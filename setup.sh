#!/bin/zsh -eu
setopt EXTENDED_GLOB

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

function ok() {
	# green color
	log "[0;32mok:[m $*"
}

function section() {
	# cyan color
	log "[0;36m$*[m"
}

function isSymlinked() {
	local SRC=$1
	local DST=$2
	if [[ -L ${DST} && $(readlink ${DST}) = ${SRC} ]]; then
		return 0
	else
		return 1
	fi
}


section "Step 0 -- find tools"; (
	# check if homebrew is installed
	if ! command -v brew >/dev/null 2>&1; then
		warn "Homebrew is not installed. Please install Homebrew first."
		exit 1
	else
		ok "brew"
	fi

	# check if necessary packages are installed by homebrew
	# only warn if not installed, but do not exit
	tools=(jq fzf nvim delta difft bat eza)
	for tool in "${tools[@]}"; do
		if ! command -v ${tool} >/dev/null 2>&1; then
			warn "${tool} is not installed. Please install ${tool} using Homebrew."
		else
			ok "${tool}"
		fi
	done
)

section "Step 1 -- deploy dotfiles to home directory"; (
	for SRC in ${WORKING_DIR}/dots/^*.example; do
		DST=${HOME}/.$(basename ${SRC})

		if isSymlinked $SRC $DST; then
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

	for SRC in ${WORKING_DIR}/dots/*.example; do
		DST=${HOME}/.$(basename ${SRC%.example})

		if [[ -L ${DST} ]]; then
			rm ${DST}
			changed "remove symlink ${DST##$HOME/}"
		fi

		if [[ -f ${DST} ]]; then
			skip "create file ${DST##$HOME/}"
			continue
		fi

		cp ${SRC} ${DST}
		changed "create file ${DST##$HOME/}"
	done
)

section 'Step 2 -- deploy XDG configs to ~/.config' ; (
	if [[ ! -d ~/.config ]]; then
		mkdir ~/.config
	fi

	for SRC in ${WORKING_DIR}/config/*; do
		DST=${HOME}/.config/$(basename ${SRC})

		if isSymlinked $SRC $DST; then
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

section 'Step 3 -- deploy Claude Code configs to ~/.claude' ; (
	if [[ ! -d ~/.claude ]]; then
		mkdir ~/.claude
		changed "create directory ~/.claude"
	fi

	for SRC in ${WORKING_DIR}/claude/*; do
		DST=${HOME}/.claude/$(basename ${SRC})

		if isSymlinked $SRC $DST; then
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

section 'Step 4 -- create custom zsh autoload directory' ; (
	ZSH_AUTOLOAD_PATH="${HOME}/.local/share/zsh/functions"
	if [[ ! -d ${ZSH_AUTOLOAD_PATH} ]]; then
		mkdir -p ${ZSH_AUTOLOAD_PATH}
		changed "create directory ${ZSH_AUTOLOAD_PATH##$HOME/}"
	else
		skip "create directory ${ZSH_AUTOLOAD_PATH##$HOME/}"
	fi
)

section 'Step 5 -- modify git global configuration '; (
	EXTRA_CONFIG_PATH=${HOME}/.dotfiles/git/extra_gitconfig
	CURRENT_EXTRA_CONFIG_PATH=$(git config --global include.path || echo "")

	if [[ $CURRENT_EXTRA_CONFIG_PATH != ${EXTRA_CONFIG_PATH} ]]; then
		git config --add --global include.path ${EXTRA_CONFIG_PATH}
		changed "Add extra config to include.path"
	else
		skip "Add extra config to include.path"
	fi

	COMMON_IGNORE_PATH=${HOME}/.dotfiles/git/common_gitignore
	CURRENT_COMMON_IGNORE_PATH=$(git config --global core.excludesfile || echo "")

	if [[ $COMMON_IGNORE_PATH != $CURRENT_COMMON_IGNORE_PATH ]]; then
		git config --add --global core.excludesfile ~/.dotfiles/git/common_gitignore
		changed "Add common ignore list to core.excludesfile"
	else
		skip "Add common ignore list to core.excludesfile"
	fi
)
