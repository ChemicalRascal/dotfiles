# Environment variables.
export EDITOR="vim"
export RSYNC_PARTIAL_DIR=".rsync-tmp"
export QUOTING_STYLE="literal"

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

servers=("d56c06d08312ff1bc4d1965a870e95e7" "09fdca3e7825007813820dfd9436f5bb")

# If we're on a particular server, change PATHs.
if [[ ${servers[(I)$(echo $HOSTNAME | md5sum | cut -f1 -d' ')]} ]]; then
  export PATH=$HOME/bin:$PATH
  export LIBRARY_PATH=$HOME/homeroot/usr/local/lib
  export LD_LIBRARY_PATH=$HOME/homeroot/usr/local/lib
  export C_INCLUDE_PATH=$HOME/homeroot/usr/local/include
  export CPLUS_INCLUDE_PATH=$HOME/homeroot/usr/local/include
fi
