#
# ~/.bash_profile
#

export PATH="$HOME/.local/share/bin:$PATH"
export $(run-parts f | xargs)

[[ -f ~/.bashrc ]] && . ~/.bashrc

if [ -z "$DISPLAY" ] && [ -n "$XDG_VTNR" ] && [ "$XDG_VTNR" -eq 1 ]; then
  exec /usr/bin/Hyprland
fi

