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

# Convert a flac file into a v0 lame-encoded mp3.
# First argument is the flac, second (if given) is a
# second input for ffmpeg, such as an album art image.
flac_mp3() {
  ffmpeg -i ${1}\
    ${2:+"-i"} ${2:+${2}}\
    -map 0:0 -map 1:0\
    -metadata:s:v title="Album cover"\
    -metadata:s:v comment="Cover (Front)"\
    -qscale:a 0 ${1/%flac/mp3}
}

# Random (legible) characters on terminal function.
# First argument specifies period (default: 0.5 seconds.)
char_spam() {
  clear;
  strings /dev/urandom | while read i; do echo -n "$i"; sleep "${1:=0.5}"; done
}
