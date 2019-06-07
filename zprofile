# vim: set ft=zsh :

JAVA_HOME=$(/usr/libexec/java_home 2>/dev/null)
if [[ -n $JAVA_HOME ]]; then
	export JAVA_HOME
fi

# rbenv
if [ -d ~/.rbenv ]; then
	eval "$(rbenv init -)"
fi

# pyenv
if [ -d ~/.pyenv ]; then
	eval "$(pyenv init -)"
fi

# golang
if type go 1>/dev/null 2>/dev/null; then
	export GOPATH=$HOME/go
	export PATH=$PATH:$GOPATH/bin
fi

# nvm
export NVM_DIR="$HOME/.nvm"

# brew path
export PATH=/usr/local/sbin:$PATH

# user path
export PATH=~/apps/bin:$PATH

# for svn and git editor
export EDITOR=vim

# cdpath
cdpath=(~ $cdpath)
export cdpath

# rust
export PATH="$HOME/.cargo/bin:$PATH"

# load local zprofile
if [ -f ~/.zprofile_local ]; then
	source ~/.zprofile_local
fi
