# vim: set ft=sh :

# loading default bash setting for ubuntu server
if [ -f "$HOME/.profile" ]; then
	# shellcheck source=/dev/null
	. "$HOME/.profile"
	return
fi

# loading custom bash settings
if [ -f "$HOME/.bashrc" ]; then
	# shellcheck source=/dev/null
	. "$HOME/.bashrc"
fi

PS1="\\[[0;35m\\]\\u@\\h\\[[m\\]:\\[[0;34m\\]\\w\\[[m\\] \$ "


# homebrew path
export PATH=/usr/local/bin:$PATH
export MANPATH=/usr/local/share/man:$MANPATH

# user path
export PATH=~/apps/bin:$PATH

# nvm
if [ -f ~/.nvm/nvm.sh ]; then
	# shellcheck source=/dev/null
	. ~/.nvm/nvm.sh
fi

# rbenv
if [ -d ~/.rbenv ]; then
	eval "$(rbenv init -)"
fi

# loading local setting
if [ -f ~/.bash_local ]; then
	# shellcheck source=/dev/null
	. ~/.bash_local
fi

