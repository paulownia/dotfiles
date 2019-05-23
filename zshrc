# vim: set ft=zsh :

# basic aliases
alias ls=" ls -G"
alias ll="ls -lF"
alias la="ls -A"
alias here="open ."
alias home="open ~/"
alias edit="open -a CotEditor"
alias al="ag --pager 'less -R'"
alias twitter="open -na 'Google Chrome' --args --app=https://mobile.twitter.com/"
alias bash="HISTFILE=${HOME}/.bash_history /bin/bash"

# for svn and git editor
export EDITOR=vim

# brew path
export PATH=/usr/local/sbin:$PATH

# user path
export PATH=~/apps/bin:$PATH

# prompt setting
case "${OSTYPE}" in
	darwin*)
		X_PROMPT="%{[0;32m%}${USER}@${HOST%%.*}%{[m%}:%{[0;34m%}%3~%{[m%}"
		;;
	linux*)
		X_PROMPT="%{[0;35m%}${USER}@${HOST%%.*}%{[m%}:%{[0;34m%}%1~%{[m%}"
		;;
esac

function zle-line-init zle-keymap-select {
  case $KEYMAP in
    main|viins)
    PROMPT="${X_PROMPT} %{[0;36m%}i%{[m%}%(!.#.$) "
    ;;
    vicmd)
    PROMPT="${X_PROMPT} %{[0;31m%}n%{[m%}%(!.#.$) "
    ;;
  vivis|vivli)
    PROMPT="${X_PROMPT} %{[0;31m%}v%{[m%}%(!.#.$) "
    ;;
  esac
  zle reset-prompt
}
zle -N zle-line-init
zle -N zle-keymap-select

# history
export HISTFILE=${HOME}/.zsh_history
export HISTSIZE=10000
export SAVEHIST=10000
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt EXTENDED_HISTORY

# zsh binding style
bindkey -v

# zsh history searching
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey '' history-beginning-search-backward-end
bindkey '' history-beginning-search-forward-end
bindkey -a '' vi-beginning-of-line
bindkey -a '' vi-end-of-line
bindkey -v '' vi-beginning-of-line
bindkey -v '' vi-end-of-line
bindkey -a '' history-incremental-search-backward
bindkey -v '' history-incremental-search-backward

# script alias
alias -s rb="ruby"
alias -s js="node"
alias -s txt="edit"

# beep
setopt no_hist_beep
setopt no_list_beep

# cd extention
setopt auto_cd
setopt auto_pushd

cdpath=(~ $cdpath)
export cdpath


# ---

function isInstalled() {
	if [ $# -ne 1 ]; then
		return 2
	fi

	type "$1" 1>/dev/null 2>/dev/null
	return $?;
}

function isBrewed() {
	if [ $# -ne 1 ]; then
		return 2
	fi

	test -e "/usr/local/bin/$1";
	return $?
}

function checkCommand() {
	if [ $# -ne 1 ]; then
		return 2
	fi

	if isInstalled "$1"; then
		return 0
	fi

	if isInstalled brew; then
		echo "'$1' is not installed. Type 'brew install $1'"
	else
		echo "'$1' is not installed. Set up homebrew and then type 'brew install $1'"
	fi

	return 1
}

# zsh completion
autoload -U compinit
compinit

zstyle ':completion:*:default' menu selection
zstyle ':completion:*' verbose yes
zstyle ':completion:*' completer _expand _complete _match _prefix _approximate _list _history
zstyle ':completion:*:messages' format "%{[1;33m%}%d %{[m%}"
zstyle ':completion:*:warnings' format "%{[1;31m%}No matches for: %d %{[m%}"
zstyle ':completion:*:descriptions' format "%{[1;34m%}%d %{[m%}"
zstyle ':completion:*:corrections' format "%{[1;33m%}%d %{[1;31m%}(errors: %e)%b %{[m%}"
zstyle ':completion:*:options' description 'yes'
zstyle ':completion:*' group-name ''


# settings for java
JAVA_HOME=$(/usr/libexec/java_home 2>/dev/null)
if [[ -n $JAVA_HOME ]]; then
	export JAVA_HOME
	alias javac="javac -J-Dfile.encoding=UTF-8"
	alias java="java -Dfile.encoding=UTF-8"
fi


# vim
if isBrewed vim; then
	alias vi=/usr/local/bin/vim
fi


# nvm
export NVM_DIR="$HOME/.nvm"

if [ -f ~/.nvm/nvm.sh ]; then
	# installed manually
	source ~/.nvm/nvm.sh

elif [ -f /usr/local/opt/nvm/nvm.sh ]; then
	# installed by homebrew
	if [ ! -d $HOME/.nvm ]; then
		mkdir $HOME/.nvm
	fi
	source /usr/local/opt/nvm/nvm.sh
fi

if isInstalled npm; then
	if [ ! -f ~/.npm_completion ]; then
		npm completion > ~/.npm_completion
	fi
	source ~/.npm_completion
fi

# golang
if isInstalled go;  then
	export GOPATH=$HOME/go
	export PATH=$PATH:$GOPATH/bin
fi

# rbenv
if [ -d ~/.rbenv ]; then
	eval "$(rbenv init -)"
fi

# pyenv
if [ -d ~/.pyenv ]; then
	eval "$(pyenv init -)"
fi

# loading local setting
if [ -f ~/.zshrc.local ]; then
	echo "Please rename .zshrc.local to .zshrc_local"
	source ~/.zshrc.local
fi

if [ -f ~/.zshrc_local ]; then
	source ~/.zshrc_local
fi

# enable direnv
if checkCommand direnv; then
	eval "$(direnv hook zsh)"
fi

# alias for hub command
if checkCommand hub; then
   eval "$(hub alias -s)"
fi

# functions
function jl() {
	if ! checkCommand jq; then
		return 1
	fi

	local QUERY
	local FILE

	if [ -p /dev/stdin ]; then
		# pipe: cat hoge.json | jl .
		if [ $# -eq 0 ]; then
			QUERY="."
		else
			QUERY="$1"
		fi
		FILE="-"
	elif [ -t 0 ]; then
		# file: jl . hoge.json
		if [ $# -eq 1 ]; then
			QUERY="."
			FILE=$1
		elif [ $# -eq 2 ]; then
			QUERY="$1"
			FILE="$2"
		else
			return 1
		fi
	else
		# redirect stdin: jl . <hoge.json
		if [ $# -eq 0 ]; then
			QUERY="."
		else
			QUERY="$1"
		fi
		FILE="-"
	fi

	jq "$QUERY" -C 2>&1 $FILE | less -R
}

# launchctl
function launchctl-start() {
	if ! checkCommand peco; then
		return 1
	fi

	local SERVICE_NAME=$(launchctl list | grep "^-" | fzf | head -n 1 | cut -f 3)

	if [ -n "$SERVICE_NAME" ]; then
		echo "Start ${SERVICE_NAME}"
		launchctl start $SERVICE_NAME
	else
		return 1
	fi
}

function launchctl-stop() {
	if ! checkCommand peco; then
		return 1
	fi

	local SERVICE_NAME=$(launchctl list | grep -v "^-" | fzf | head -n 1 | cut -f 3)

	if [ -n "$SERVICE_NAME" ]; then
		echo "Stop ${SERVICE_NAME}"
		launchctl stop $SERVICE_NAME
	else
		return 1
	fi
}

# git
alias git-vimdiff="git difftool --tool=vimdiff --no-prompt"

autoload -Uz vcs_info

setopt prompt_subst
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' stagedstr "%F{yellow}!"
zstyle ':vcs_info:git:*' unstagedstr "%F{red}+"
zstyle ':vcs_info:*' formats "%F{green}%c%u[%b]%f"
zstyle ':vcs_info:*' actionformats '[%b|%a]'
precmd () {
	vcs_info
	RPROMPT='${vcs_info_msg_0_}'
}


# find and cd
function fcd() {
	if ! checkCommand peco; then
		return 1
	fi

	if [ -z "$1" ]; then
		return 1
	fi

    # https://developer.apple.com/library/mac/documentation/Carbon/Conceptual/SpotlightQuery/Concepts/QueryFormat.html
    local MD_QUERY="kMDItemContentType == 'public.folder' && kMDItemFSName == '$1*'"

	local RESULT=$(mdfind -onlyin ~ "$MD_QUERY" | peco)

	if [ -z "$RESULT" ]; then
		return 1
	fi

	echo $RESULT
	cd $RESULT
}

# find regular files (excludes invisible files)
function ff() {
	mdfind -onlyin . -name "$1"
}

function fvi() {
	local F=$(ff "$1" | peco)
	if [[ -n $F ]]; then
		vi $F
	fi
}

function title() {
	if [ -z "$1" ]; then
		return 1;
	fi

	echo -en "\033];$@\007"
}

# -- google search
source ~/.dotfiles/zsh/google

# -- dev command
source ~/.dotfiles/zsh/dev

function print_known_hosts (){
    if [ -f $HOME/.ssh/known_hosts ]; then
        cat $HOME/.ssh/known_hosts | tr ',' ' ' | cut -d ' ' -f 1
    fi
}
_cache_hosts=($(print_known_hosts))

# Use local mocha if mocha is not installed in global
if ! isInstalled mocha; then
	function mocha() {
		local _mocha=$(npm bin)/mocha
		if [ -x ${_mocha} ]; then
			${_mocha} "$@"
		else
			echo "mocha not found" >&2
		fi
	}
fi

# to open this git repo in sourcetree
function sourcetree() {
	local dir=$(git rev-parse --show-cdup)
	if [ -z "${dir}" ]; then
		dir="."
	fi
	open -a SourceTree ${dir}
}


