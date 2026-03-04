#!/bin/bash
# Claude Code status line — mirrors ~/.zshrc PROMPT style

input=$(cat)

cwd=$(echo "$input" | jq -r '.workspace.current_dir // .cwd // ""')
used_pct=$(echo "$input" | jq -r '.context_window.used_percentage // empty')
cost=$(echo "$input" | jq -r '.cost.total_cost_usd // empty')
model=$(echo "$input" | jq -r '.model.display_name // empty')

# Replace $HOME prefix with ~
short_path="${cwd/#$HOME/~}"

# Shorten to last 3 path components (mirrors zsh %3~)
short_path=$(echo "$short_path" | awk -F'/' '{
  n = NF
  if (n <= 3) {
    print $0
  } else {
    printf "%s/%s/%s", $(n-2), $(n-1), $n
  }
}')

# ANSI color codes
CYAN='\033[0;36m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
RED='\033[0;31m'
BOLD='\033[1m'
RESET='\033[0m'

printf "${BOLD}${CYAN}%s${RESET}" "$short_path"

# Model name
if [ -n "$model" ]; then
	printf " ${CYAN}(%s)${RESET}" "$model"
fi


# Context usage with color based on usage level
color="$GREEN"
if [ -n "$used_pct" ]; then
  if [ "$used_pct" -ge 80 ]; then
    color="$RED"
  elif [ "$used_pct" -ge 50 ]; then
    color="$YELLOW"
  fi
else
  used_pct="0"
fi
printf " ${color}ctx:%s%%${RESET}" "$used_pct"

# Session cost
if [ -n "$cost" ]; then
  printf " ${YELLOW}cost:\$%.3f${RESET}" "$cost"
fi
