#! /bin/bash
set -euo pipefail
pgrep_gnome=$(ps aux  | grep gnome-session-binary | grep session=gnome | awk '{print $2}')
if [[ -n "$pgrep_gnome" ]]; then
    echo 'gnome'
else
    >&2 echo 'not implement yet.'
    exit 1
fi
#pgrep_lightdm=$(ps aux | grep lightdm | grep -v grep | wc -l)
#if [[ $pgrep_lightdm -gt 0 ]]; then
#    de='lightdm'
#else
#    >&2 echo 'no desktop environment has been found.'
#    exit 1
#fi
#if [[ "$de" == 'lightdm' ]]; then
#    pgrep_xfce=$(ps uax --forest | grep 'lightdm --session-child' -A1 | grep xfce4 | wc -l)
#    if [[ $pgrep_xfce -gt 0 ]]; then
#        echo xfce
#    else
#        >&2 echo 'not implement yet.'
#        exit 1
#    fi
#fi
