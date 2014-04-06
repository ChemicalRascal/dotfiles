# Lines configured by zsh-newuser-install
HISTFILE=~/.zshhist
HISTSIZE=100
SAVEHIST=100
setopt appendhistory extended_glob hist_ignore_dups hist_ignore_space
bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/jdenholm/.zshrc'

autoload -Uz compinit promptinit
compinit
promptinit
# End of lines added by compinstall
# Prompt theme
prompt adam2 8bit

# ----
# Aliases moved to .zshenv.

# ----
#Handle dircolors.
eval `dircolors ~/.dircolors/ansi-solarized-dark`
