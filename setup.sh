#!/bin/bash

DOTFILE_DIR=$(cd $(dirname $0); pwd)

# --- copy dotfile

FILE_LIST=`ls $DOTFILE_DIR | grep -v setup.sh`

for i in $FILE_LIST; do

	FILE_SRC=${DOTFILE_DIR}/${i}
	FILE_DST=${HOME}/.${i}

	if [ -L $FILE_DST ]; then
		rm $FILE_DST && echo "${FILE_DST} is symbolic link, remove it."

	elif [ -e $FILE_DST ]; then
		mv $FILE_DST $FILE_DST.org && echo "${FILE_DST} already exists, rename it."
	fi
	
	ln -s $FILE_SRC $FILE_DST
done


# --- install vundle.vim

VUNDLE_DIR=${DOTFILE_DIR}/vim/bundle
if [ ! -d ${VUNDLE_DIR} ]; then
	mkdir -p ${VUNDLE_DIR}
fi

if [ ! -d ${VUNDLE_DIR}/vundle ]; then
	git clone https://github.com/gmarik/vundle ${VUNDLE_DIR}/vundle
else
	echo "Vundle is already installed"
fi

