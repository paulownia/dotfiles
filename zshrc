# vim: set ft=sh :

bindkey -e

# basic aliases
alias ls="ls -G"
alias ll="ls -lF"
alias la="ls -A"
alias here="open ."
alias home="open ~/"
alias edit="open -a CotEditor"
alias al="ag --pager 'less -R'"

PS1="%{[0;32m%}${HOST}:%1~%{[m%} %{[0;35m%}${USER}%(!.#.$)%{[m%} "

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
  eval "$(rbenv init - zsh)"
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

# cd & mdfind 
type mdfind >/dev/null 2>&1 && \
function cdd {
    local arg="$1" path i=0 j selnum selpath OUTPUT
    declare -a pathes
    if [ -z "$arg" ] || [ "$arg" = "-h" ] ; then
        echo "Usage:"
        echo "  $FUNCNAME STRING"
        return
    fi
    # mdfind search is case insensitive
    md_query='kMDItemContentType == "public.folder" && kMDItemDisplayName == "'${arg}'"'
    for path in $(mdfind -onlyin ~ "$md_query" | head -n 10) ; do
        path=$(echo "$path" | sed -e 's/\+/ /g')
        test -d "$path" || continue
        i=$((i+1))
        pathes[$i]="$path"
    done
    if [ -z "${pathes[1]}" ] ; then
        # Nothing search result.
        return
    fi
    if [ $i -ge $LINES ] ; then
        OUTPUT=$PAGER
        test -z "$OUTPUT" && OUTPUT=cat
    else
        OUTPUT=cat
    fi
    for j in $(seq 1 $i) ; do
        printf "%2d: %s\n" $j "${pathes[$j]}"
    done | $OUTPUT
    read -p "select number: " selnum
    selpath="${pathes[$selnum]}"
    if [ -z "$selpath" ] ; then
        echo "$FUNCNAME: select is wrong." 1>&2
        return 1
    fi
    cd "$selpath"
}
