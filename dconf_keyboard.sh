#! /bin/bash

dconf load / <<EOF
[org/gnome/desktop/input-sources]
current=uint32 0
mru-sources=[('xkb', 'us'), ('xkb', 'th'), ('ibus', 'anthy')]
per-window=true
sources=[('xkb', 'us'), ('xkb', 'th'), ('ibus', 'anthy')]
xkb-options=['ctrl:swapcaps']
EOF
