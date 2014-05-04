# Environment variables.
export EDITOR="vim"
export RSYNC_PARTIAL_DIR=".rsync-tmp"

# wiki-search-html variable.
export wiki_browser=$(which firefox)

# Aliases, functions, keybindings.
# System-wide stuff.
source ~/.aliases/gen

# Commandline-focused aliases.
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias rs='set noglob; eval `resize`'
alias info='info --vi-keys'

# Random (legible) characters on terminal function.
# First argument specifies period (default: 0.5 seconds.)
char_spam() {
	clear;
	strings /dev/urandom | while read i; do echo -n "$i"; sleep "${1:=0.5}"; done
}
