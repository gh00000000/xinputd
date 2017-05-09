#!/bin/sh

VERSION=2.7

doe()
{
    err=$?
    if [ $err -ne 0 ]
    then
        echo "ERROR: $*" 1>&2
        exit $?
    fi
}

wget https://raw.githubusercontent.com/anish/archlinux/master/wine-silverlight/30-win32-aliases.conf
doe getting 30-win32-aliases.conf failed

wget https://git.archlinux.org/svntogit/community.git/plain/trunk/PKGBUILD?h=packages/wine-staging -O PKGBUILD
doe getting PKGBUILD failed

patch -p 1 < PKGBUILD.patch
doe patch failed

cat PKGBUILD |sed '/sha1sums/ {N;d;}'|sed "s/source=(.*/source=(\"wine-staging-$VERSION.tar.xz\"/"|sed '/30-win32-aliases.conf)/ a sha1sums=(SKIP\n    SKIP)' | sed "s/^pkgver=.*/pkgver=$VERSION/"> PKGBUILD.tmp
doe sed failed
mv PKGBUILD.tmp PKGBUILD

./wine-staging-make-archive.sh
doe failed to make archive

makepkg -s

