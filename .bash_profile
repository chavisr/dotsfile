#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc

# if [ -z $DISPLAY ] && [ $(tty) = /dev/tty2 ]; then
# 	exec env XDG_CURRENT_DESKTOP=bspwm startx
# fi

if [ -z $WAYLAND_DISPLAY ] && [ $(tty) = /dev/tty1 ]; then
  # exec env XDG_CURRENT_DESKTOP=river dbus-run-session river
  exec dbus-run-session niri --session
fi

# if [ -e /home/chavi/.nix-profile/etc/profile.d/nix.sh ]; then . /home/chavi/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer
