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

# completion installed by homebrew
fpath=($(brew --prefix)/share/zsh/site-functions $fpath)

# zsh completion
autoload -U compinit
compinit

# nvm
if [ -f ~/.nvm/nvm.sh ]; then
  source ~/.nvm/nvm.sh
fi

# rbenv
if [ -d ~/.rbenv ]; then
  export PATH=~/.rbenv/bin:$PATH
  eval "$(rbenv init - zsh)"
fi

# loading local setting
if [ -f ~/.zprofile.local ]; then
	source ~/.zprofile.local
fi


# functions
function jl() {
  local QL

  if [ -p /dev/stdin ]; then
    if [ -n "$1" ]; then
      QL=$1
    else
      QL="."
    fi
    jq "$QL" -C 2>&1 - | less -R
  else
    if [ -n "$2" ]; then
      QL=$2
    else
      QL="."
    fi
    cat "$1" | jq "$QL" -C 2>&1 | less -R
  fi
}

# git
alias git-vimdiff="git difftool --tool=vimdiff --no-prompt"
