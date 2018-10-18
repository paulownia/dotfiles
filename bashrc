# vim: set ft=sh :

# non login shell settings

if [ -f "$HOME/.bash_profile" ]; then
	# shellcheck source=/dev/null
	. "$HOME/.bash_profile"
fi

c_blue="[34m"
c_magenta="[35m"
c_bold_yellow="[1;33m"
c_reset="[m"
PS1="${c_magenta}\\u@\\h${c_reset}:${c_blue}\\w${c_reset} ${c_bold_yellow}bash${c_reset}\$ "
