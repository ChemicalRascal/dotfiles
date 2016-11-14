#!/bin/zsh

DEFAULT_SESSION="xmonad"

xrdb -load ~/.Xresources
#xcompmgr &

#Handle default.
if [[ -z $1 ]]; then
  SESSION=$DEFAULT_SESSION
else
  SESSION=$1
fi

#Handle setting R-Alt as the compose key.
setxkbmap -option "compose: ralt"

#Handle default mouse cursor in X.
xsetroot -cursor_name left_ptr

#Handle systray
trayer --edge top --align right --SetDockType true --SetPartialStrut true \
  --expand true --width 5 --height 12 --transparent true --tint 0x000000 &

#Handle java not being terrible
export _JAVA_AWT_WM_NONREPARENTING=1

#Run the damn thing.
mkdir -p ~/.cache/$SESSION
exec $SESSION >> ~/.cache/$SESSION/stdout 2>> ~/.cache/$SESSION/stderr
