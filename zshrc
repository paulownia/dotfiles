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

# homebrew path
export PATH=/usr/local/bin:$PATH
export MANPATH=/usr/local/share/man:$MANPATH

# user path
export PATH=~/apps/bin:$PATH

# zsh setting
export PROMPT="%{[0;32m%}${HOST%%.*}:%1~%{[m%} %{[0;35m%}${USER}%(!.#.$)%{[m%} "
export HISTFILE=${HOME}/.zsh_history
export HISTSIZE=1000
export SAVEHIST=1000
setopt hist_ignore_dups
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

# homebrew zsh completion
if type brew >/dev/null 2>/dev/null; then
  BREW_HOME=$(brew --prefix)

  # completion installed by homebrew
  fpath=($BREW_HOME/share/zsh/site-functions $fpath)

  BREW_COMP_SRC=$BREW_HOME/Library/Contributions/brew_zsh_completion.zsh
  BREW_COMP_DST=$BREW_HOME/share/zsh/site-functions/_brew
  if [[ ! ("$BREW_COMP_SRC" -ef "$BREW_COMP_DST") ]]; then
    ln -s $BREW_COMP_SRC $BREW_COMP_DST
  fi
fi

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
  source ~/.zshrc.local
fi


# functions
function jl() {
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
	local SERVICE_NAME

	SERVICE_NAME=$(launchctl list | grep "^-" | peco | head -n 1 | cut -f 3)

	if [ -n "$SERVICE_NAME" ]; then
		echo "Start ${SERVICE_NAME}"
		launchctl start $SERVICE_NAME
	else
		return 1
	fi
}

function launchctl-stop() {
	local SERVICE_NAME

	SERVICE_NAME=$(launchctl list | grep -v "^-" | peco | head -n 1 | cut -f 3)

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
