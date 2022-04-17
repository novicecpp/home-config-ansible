#!/bin/bash
set -euo pipefail
cd emacs
git clean -fdx
./autogen.sh
./configure --prefix=/usr --exec-prefix=/usr --bindir=/usr/bin --sbindir=/usr/sbin --sysconfdir=/etc --datadir=/usr/share --includedir=/usr/include --libdir=/usr/lib64 --libexecdir=/usr/libexec --localstatedir=/var --sharedstatedir=/var/lib --mandir=/usr/share/man --infodir=/usr/share/info --with-dbus --with-gif --with-jpeg --with-png --with-rsvg --with-tiff --with-xft --with-xpm --with-x-toolkit=gtk3 --with-gpm=no --without-xwidgets --with-modules --with-harfbuzz --with-cairo --with-json --with-mailutils --with-native-compilation
numbers_cpu=$(cat /proc/cpuinfo | awk '/^processor/{print $3}' | wc -l)
#make NATIVE_FULL_AOT=1 -j
make -j $(($numbers_cpu - 1))
systemctl stop --user emacs
sudo make uninstall
sudo make install
systemctl start --user emacs
