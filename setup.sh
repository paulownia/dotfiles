#!/bin/bash

SCRIPT_FILE=${0##*/}
DOTFILE_DIR=$(cd $(dirname $0); pwd)


# --- functions

log() {
	echo $@
} >&2


# --- copy dotfile

FILE_LIST=$(ls $DOTFILE_DIR | grep -v $SCRIPT_FILE)

for i in $FILE_LIST; do

	FILE_SRC=${DOTFILE_DIR}/${i}
	FILE_DST=${HOME}/.${i}

	if [ -L $FILE_DST ]; then
		rm $FILE_DST && log "${FILE_DST} is symbolic link, remove it."

	elif [ -e $FILE_DST ]; then
		mv $FILE_DST $FILE_DST.org && log "${FILE_DST} already exists, rename it."
	fi
	
	ln -s $FILE_SRC $FILE_DST
done


# --- install vundle.vim

cd ${DOTFILE_DIR}
git submodule init
git submodule update

