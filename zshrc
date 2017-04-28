# vim: set ft=zsh :

# basic aliases
alias ls="ls -G"
alias ll="ls -lF"
alias la="ls -A"
alias here="open ."
alias home="open ~/"
alias edit="open -a CotEditor"
alias al="ag --pager 'less -R'"


# for svn and git editor
export EDITOR=vim

# java
alias javac="javac -J-Dfile.encoding=UTF-8"
alias java="java -Dfile.encoding=UTF-8"

# brew extra path
export PATH=/usr/local/sbin:$PATH

# user path
export PATH=~/apps/bin:$PATH

# zsh setting
case "${OSTYPE}" in
	darwin*)
		export PROMPT="%{[0;32m%}${USER}@${HOST%%.*}%{[m%}:%{[0;34m%}%3~%{[m%}%(!.#.$) "
		;;
	linux*)
		export PROMPT="%{[0;35m%}${USER}@${HOST%%.*}%{[m%}:%{[0;34m%}%1~%{[m%}%(!.#.$) "
		;;
esac
export HISTFILE=${HOME}/.zsh_history
export HISTSIZE=1000
export SAVEHIST=1000
setopt hist_ignore_dups
setopt EXTENDED_HISTORY
setopt AUTO_CD

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

alias -s rb="ruby"
alias -s js="node"
alias -s txt="edit"


function isInstalled() {
	if [ $# -ne 1 ]; then
		return 1
	fi

	type "$1" 1>/dev/null 2>/dev/null
	return $?;
}


function isBrewed() {
	if [ $# -ne 1 ]; then
		return 2
	fi

	if isInstalled "$1"; then
		return 0
	fi

	if isInstalled brew; then
		echo "Command '$1' is required. please type 'brew install $1'"
	else
		echo "Command '$1' is required. please install homebrew and type 'brew install $1'"
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


# nvm
if [ -f ~/.nvm/nvm.sh ]; then
	source ~/.nvm/nvm.sh

	if [ ! -f ~/.npm_completion ]; then
		npm completion > ~/.npm_completion
	fi
	source ~/.npm_completion
fi

# rbenv
if [ -d ~/.rbenv ]; then
	export PATH=~/.rbenv/bin:$PATH
	eval "$(rbenv init - zsh)"
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
if isBrewed direnv; then
	eval "$(direnv hook zsh)"
fi

# functions
function jl() {
	if ! isBrewed jq; then
		return 1
	fi

	local QUERY
	local FILE

	if [ -p /dev/stdin ]; then
		if [ $# -eq 0 ]; then
			QUERY="."
		else
			QUERY="$1"
		fi
		FILE="-"
	else
		if [ $# -eq 1 ]; then
			QUERY="."
			FILE=$1
		elif [ $# -eq 2 ]; then
			QUERY="$1"
			FILE="$2"
		else
			return 1
		fi
	fi

	jq "$QUERY" -C 2>&1 $FILE | less -R
}

# launchctl
function launchctl-start() {
	if ! isBrewed peco; then
		return 1
	fi

	local SERVICE_NAME=$(launchctl list | grep "^-" | peco | head -n 1 | cut -f 3)

	if [ -n "$SERVICE_NAME" ]; then
		echo "Start ${SERVICE_NAME}"
		launchctl start $SERVICE_NAME
	else
		return 1
	fi
}

function launchctl-stop() {
	if ! isBrewed peco; then
		return 1
	fi

	local SERVICE_NAME=$(launchctl list | grep -v "^-" | peco | head -n 1 | cut -f 3)

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
	if ! isBrewed peco; then
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

function title() {
	if [ -z "$1" ]; then
		return 1;
	fi

	echo -en "\033];$1\007"
}

# -- dev command
function dev() {
	local MODE KEY OPT OPTARG OPTIND
	local CD_LIST CD_PATH

	MODE="move"
	while getopts s:l OPT
	do
		case $OPT in
			s)
				MODE="set"
				KEY=$OPTARG
				;;
			l)
				cat ~/.dev
				return 0
				;;
		esac
	done

	# echo $MODE

	if [ "$MODE" == "set" ]; then
		if [ ! -f ~/.dev ]; then
			echo "$KEY\t$(pwd)" > ~/.dev
		else
			CD_LIST=$(cat ~/.dev | grep -v "$KEY")
			echo "$CD_LIST\n$KEY\t$(pwd)" > ~/.dev
		fi
	else
		KEY=default
		if [ -n "$1" ]; then
			KEY=$1
		fi

		CD_PATH=$(cat ~/.dev | grep "^$KEY" | cut -f2)
		if [ -z $CD_PATH -o ! -d $CD_PATH ]; then
			return 1
		fi

		cd $CD_PATH
		title $KEY
		pwd
	fi
}

function _dev() {
	local -a CD_LIST
	CD_LIST=( $(cat ~/.dev | cut -f 1) )
	_describe "Projects" CD_LIST
}

compdef _dev dev

function print_known_hosts (){
    if [ -f $HOME/.ssh/known_hosts ]; then
        cat $HOME/.ssh/known_hosts | tr ',' ' ' | cut -d ' ' -f 1
    fi
}
_cache_hosts=($(print_known_hosts))


function sacred-war-in-the-eternal-darkness () {
	node -e 'var d=(Date.now()-1467752400000)/86400000|0;console.log(JSON.stringify({レグナード: (d+2)%4+1, ダークキング: (d%4)+1,メイヴ: (d-1)%4+1}));'
}

# if mocha is not installed in global
if ! isInstalled mocha; then
	function mocha() {
		$(npm bin)/mocha "$@"
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
