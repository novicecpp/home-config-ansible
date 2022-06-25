#!/bin/bash
set -euo pipefail

if [[ ! -d "emacs" ]]; then
   git clone git://git.sv.gnu.org/emacs.git emacs
fi

cd emacs
git clean -fdx
./autogen.sh
./configure CFLAGS='-g3 -O3 -march=native -mtune=native' --prefix=/usr --exec-prefix=/usr --bindir=/usr/bin --sbindir=/usr/sbin --sysconfdir=/etc --datadir=/usr/share --includedir=/usr/include --libdir=/usr/lib64 --libexecdir=/usr/libexec --localstatedir=/var --sharedstatedir=/var/lib --mandir=/usr/share/man --infodir=/usr/share/info --with-dbus --with-gif --with-jpeg --with-png --with-rsvg --with-tiff --with-xft --with-xpm --with-x-toolkit=gtk3 --with-gpm=no --without-xwidgets --with-modules --with-harfbuzz --with-cairo --with-json --with-mailutils --with-native-compilation
#make NATIVE_FULL_AOT=1 $(nproc)
make -j $(( $(nproc) - 1))
systemctl stop --user emacs
sudo make uninstall
sudo make install install-etc #install-etc for emacs icon
systemctl start --user emacs
