#!/bin/bash
set -euo pipefail

if [[ ! -d "emacs/.git" ]]; then
    >&2 echo 'Error: "emacs" local repository not found. Clone the emacs with "clone.sh" first.'
    exit 1
fi

cd emacs
git clean -fdx
./autogen.sh autoconf
# copy from fedora flag
# --without-gpm
# replaced/enabled by pgtk
#--with-x-toolkit=gtk3 --with-xft --with-xpm --with-cairo
# deprecated
# --with-json
./configure \
    --prefix=/usr --exec-prefix=/usr --bindir=/usr/bin --sbindir=/usr/sbin --sysconfdir=/etc --datadir=/usr/share --includedir=/usr/include --libdir=/usr/lib64 --libexecdir=/usr/libexec --localstatedir=/var --sharedstatedir=/var/lib --mandir=/usr/share/man --infodir=/usr/share/info \
    --without-gpm \
    --with-dbus --with-harfbuzz --with-xwidgets --with-mailutils --with-sqlite3 --with-libsystemd \
    --with-gif --with-jpeg --with-png --with-rsvg --with-tiff --with-webp \
    --with-native-compilation --with-tree-sitter --with-pgtk \
    CFLAGS="-O3 -m64 -march=native -mtune=native -pipe -Wall -Wp,-U_FORTIFY_SOURCE,-D_FORTIFY_SOURCE=3 -Wp,-D_GLIBCXX_ASSERTIONS -fstack-protector-strong" \
    CXXFLAGS="-O3 -m64 -march=native -mtune=native -pipe -Wall -Wp,-U_FORTIFY_SOURCE,-D_FORTIFY_SOURCE=3 -Wp,-D_GLIBCXX_ASSERTIONS -fstack-protector-strong" \
    LDFLAGS="-Wl,-z,relro"
make -j $(( $(nproc) - 1))
systemctl stop --user emacs
sudo make uninstall
sudo make install install-etc #install-etc for emacs icon
systemctl start --user emacs --no-block
