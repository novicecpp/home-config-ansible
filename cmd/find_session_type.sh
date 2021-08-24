#! /bin/bash
pgrep_xorg=$(ps aux | grep -E 'Xorg.+\:0' | wc -l)
if [[ $pgrep_xorg -gt 0 ]]; then
    echo x11
else
    >2 echo 'not implement yet.'
fi
