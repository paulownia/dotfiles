# vim: set ft=sh :

# basic aliases
alias ls="ls -G"
alias ll="ls -lF"
alias la="ls -A"
alias here="open ."
alias home="open ~/"
alias edit="open -a CotEditor"
alias al="ag --pager 'less -R'"

PS1="\[[0;35m\]\u@\h\[[m\]:\[[0;34m\]\W\[[m\] \$ "

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
  . ~/.nvm/nvm.sh
fi

# rbenv
if [ -d ~/.rbenv ]; then
  export PATH=~/.rbenv/bin:$PATH
  eval "$(rbenv init -)"
fi

# loading local setting
if [ -f ~/.bash_local ]; then
  . ~/.bash_local
fi

# functions
function jl() {

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
