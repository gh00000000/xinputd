#!/bin/sh

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

./wine-staging-make-archive.sh
doe failed to make archive

makepkg -s
