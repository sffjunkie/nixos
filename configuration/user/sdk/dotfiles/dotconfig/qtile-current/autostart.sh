#!/bin/sh

[[ -f ${XDG_CONFIG_HOME:-$HOME/.config}/sh/env.sh ]] && source ${XDG_CONFIG_HOME:-$HOME/.config}/sh/env.sh

xrdb -merge "${XDG_CONFIG_HOME:-$HOME/.config}/x11/Xresources" &

# Keyboard
setxkbmap -option altwin:swap_lalt_lwin

# Mouse
export XCURSOR_SIZE=24
xinput set-prop "MX Anywhere 2S Mouse" 282 1

# Display
#xiccd &
picom --config "${XDG_CONFIG_HOME:-$HOME/.config}/picom/picom.conf" &
nitrogen --restore &
unclutter &

# System
udiskie &

alacritty &
