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
HISTFILE=${HOME}/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
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
if [[ -n $JAVA_HOME ]]; then
	alias javac="javac -J-Dfile.encoding=UTF-8"
	alias java="java -Dfile.encoding=UTF-8"
fi

# vim
if isBrewed vim; then
	alias vi=/usr/local/bin/vim
fi

# nvm
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

# loading local setting
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

# load functions
source ~/.dotfiles/zsh/*


# -- dev command
source ~/.dotfiles/zsh/dev

# -- launchctl utilities
source ~/.dotfiles/zsh/launchctl

# -- fuctions
source ~/.dotfiles/zsh/functions

# completion ssh hosts
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

