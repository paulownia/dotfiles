# vim: set ft=sh :

# non login shell settings

if [ -f "$HOME/.bash_profile" ]; then
	# shellcheck source=/dev/null
	. "$HOME/.bash_profile"
fi

c_blue="\\[[0;34m\\]"
c_magenta="\\[[0;35m\\]"
c_bright_yellow="\\[[0;33;1m\\]"
c_default="\\[[m\\]"
PS1="${c_magenta}\\u@\\h${c_default}:${c_blue}\\w${c_default} ${c_bright_yellow}bash${c_default}\$ "
