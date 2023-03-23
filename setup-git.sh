#!/bin/zsh

cd "$(dirname "$0")" || exit 1

source ./functions

: configure git; {
	if installed delta; then
		if ! git config --get --global include.path | grep -q .gitconfig_global;  then
			git config --global --add include.path ~/.gitconfig_global
		else
			log "git config is not changed"
		fi
	else
		log "delta is not found, install git-delta"
	fi
}
