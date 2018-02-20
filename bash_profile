# vim: set ft=sh :

# loading default bash setting for ubuntu server
if [ -f "$HOME/.profile" ]; then
	# shellcheck source=/dev/null
	. "$HOME/.profile"
	return
fi

# basic aliases
alias ls="ls -G"
alias ll="ls -lF"
alias la="ls -A"
alias here="open ."
alias home="open ~/"
alias edit="open -a CotEditor"
alias al="ag --pager 'less -R'"

PS1="\[[0;35m\]\u@\h\[[m\]:\[[0;34m\]\w\[[m\] \$ "

# for svn and git editor
export EDITOR=vim

# java
alias javac="javac -J-Dfile.encoding=UTF-8"
alias java="java -Dfile.encoding=UTF-8"

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
	export PATH=~/.rbenv/bin:$PATH
	eval "$(rbenv init -)"
fi

# loading local setting
if [ -f ~/.bash_local ]; then
	# shellcheck source=/dev/null
	. ~/.bash_local
fi

# git
alias git-vimdiff="git difftool --tool=vimdiff --no-prompt"
