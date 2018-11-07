# vim: set ft=sh :

# basic aliases
alias ls="ls -G"
alias ll="ls -lF"
alias la="ls -A"
alias git-vimdiff="git difftool --tool=vimdiff --no-prompt"
alias al="ag --pager 'less -R'"
alias javac="javac -J-Dfile.encoding=UTF-8"
alias java="java -Dfile.encoding=UTF-8"

if [ "$(uname)" == 'Darwin' ]; then
	alias here="open ."
	alias home="open ~/"
	alias edit="open -a CotEditor"
fi

# prompt
c_blue='\[[34m\]'
c_magenta='\[[35m\]'
c_bold_yellow='\[[1;33m\]'
c_reset='\[[m\]'
PS1="${c_magenta}\\u@\\h${c_reset}:${c_blue}\\w${c_reset} ${c_bold_yellow}bash${c_reset}\$ "

export HISTFILE="$HOME/.bash_history"
export EDITOR=vim
