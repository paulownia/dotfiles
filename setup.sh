#!/bin/zsh -eu

WORKING_DIR=$(cd "$(dirname "$0")" && pwd)

log() {
	echo "$@"
} >&2

: copy dotfile to home directory ; {
	for SRC in ${WORKING_DIR}/dots/*; do
		DST=${HOME}/.$(basename ${SRC})

		if [[ -L $DST ]]; then
			rm ${DST} && log "${DST} is symbolic link, remove it."
		elif [[ -e $DST ]]; then
			mv ${DST} ${DST}.org && log "${DST} already exists, rename it."
		fi

		ln -s ${SRC} ${DST}
	done
}

: copy commands to ~/apps/bin ; {
	if [[ ! -d ~/apps/bin ]]; then
		mkdir -p ~/apps/bin
	fi

	for SRC in ${WORKING_DIR}/bin/*; do
		DST=${HOME}/apps/bin/$(basename ${SRC})

		if [[ -L $DST ]]; then
			rm ${DST} && log "${DST} is symbolic link, remove it."
		elif [[ -e $DST ]]; then
			mv ${DST} ${DST}.org && log "${DST} already exists, rename it."
		fi

		ln -s ${SRC} ${DST}
	done
}

: copy .config dir to home direcotry ; {
	if [[ ! -d ~/.config ]]; then
		mkdir ~/.config
	fi

	for SRC in ${WORKING_DIR}/config/*; do
		DST=${HOME}/.config/$(basename ${SRC})

		if [[ -L $DST ]]; then
			rm ${DST} && log "${DST} is symbolic link, remove it."
		elif [[ -e $DST ]]; then
			mv ${DST} ${DST}.org && log "${DST} already exists, rename it."
		fi

		ln -s ${SRC} ${DST}
	done
}

: copy nvim setting ; {
	NVIM_AUTOLOAD_PATH="${HOME}/.local/share/nvim/site/autoload"
	mkdir -p ${NVIM_AUTOLOAD_PATH}

	SRC="${WORKING_DIR}/dots/vim/autoload/plug.vim"
	DST="${NVIM_AUTOLOAD_PATH}/plug.vim"

	if [[ -e $DST ]]; then
		mv ${DST} ${DST}.org && log "${DST} already exists, rename it."
	fi

	ln -s ${SRC} ${DST}
}

