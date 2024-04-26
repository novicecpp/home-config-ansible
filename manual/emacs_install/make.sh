#!/bin/bash
set -euo pipefail

if [[ ! -d "emacs/.git" ]]; then
    >&2 echo 'Error: "emacs" local repository not found. Clone the emacs with "clone.sh" first.'
    exit 1
fi

cd emacs
git clean -fdx
./autogen.sh autoconf
PATH_OPTIONS="--prefix=/usr --exec-prefix=/usr --bindir=/usr/bin --sbindir=/usr/sbin --sysconfdir=/etc --datadir=/usr/share --includedir=/usr/include --libdir=/usr/lib64 --libexecdir=/usr/libexec --localstatedir=/var --sharedstatedir=/var/lib --mandir=/usr/share/man --infodir=/usr/share/info"
# copy from fedora build
# --without-gpm
WITHOUT_OPTIONS="--without-gpm"
# deprecated
# --with-json
# replaced/enabled by pgtk
#--with-x-toolkit=gtk3 --with-xft --with-xpm --with-cairo
WITH_OPTIONS="--with-dbus --with-harfbuzz --with-xwidgets --with-mailutils --with-sqlite3 --with-libsystemd"
IMAGE_OPTIONS="--with-gif --with-jpeg --with-png --with-rsvg --with-tiff --with-webp "
NEW_FEATURE_OPTIONS="--with-native-compilation --with-tree-sitter --with-pgtk"
# XXFLAGS all copy from fedora build
# debian/ubuntu/fedora has -fstack-protector-strong and LDFLAGS="-Wl,-z,relro"
CFLAGS="-O3 -m64 -march=native -mtune=native -pipe -Wall -Wp,-U_FORTIFY_SOURCE,-D_FORTIFY_SOURCE=3 -Wp,-D_GLIBCXX_ASSERTIONS -fstack-protector-strong"
CXXFLAGS="-O3 -m64 -march=native -mtune=native -pipe -Wall -Wp,-U_FORTIFY_SOURCE,-D_FORTIFY_SOURCE=3 -Wp,-D_GLIBCXX_ASSERTIONS -fstack-protector-strong"
LDFLAGS="-Wl,-z,relro"
# shellcheck disable=SC2086
./configure \
    ${PATH_OPTIONS} \
    ${WITHOUT_OPTIONS} \
    ${WITH_OPTIONS} \
    ${IMAGE_OPTIONS} \
    ${NEW_FEATURE_OPTIONS} \
    CFLAGS="${CFLAGS}" \
    CXXFLAGS="${CXXFLAGS}" \
    LDFLAGS="${LDFLAGS}"
make -j $(( $(nproc) - 1))
systemctl stop --user emacs
sudo make uninstall
sudo make install install-etc #install-etc for emacs icon
systemctl start --user emacs --no-block
