#!/bin/bash

# to be invoked from patch-git-for-windows.bat

cd /
rm -rf /var/lib/pacman
mkdir -p /var/lib/pacman
rm -rf /etc/pacman.d
rm -rf /var/cache/pacman
rm -rf ~/.gnupg

curl -k https://raw.githubusercontent.com/git-for-windows/git-sdk-64/main/etc/pacman.conf -o /etc/pacman.conf
curl -k https://raw.githubusercontent.com/git-for-windows/git-sdk-64/main/usr/bin/unzstd.exe -o /usr/bin/unzstd.exe
curl -k https://raw.githubusercontent.com/git-for-windows/git-sdk-64/main/usr/bin/bsdtar.exe -o /usr/bin/bsdtar.exe
curl -k https://raw.githubusercontent.com/git-for-windows/git-sdk-64/main/usr/bin/msys-lzma-5.dll -o /usr/bin/msys-lzma-5.dll
curl -k https://raw.githubusercontent.com/git-for-windows/git-sdk-64/main/usr/bin/autoreconf -o /usr/bin/autoreconf

curl -k https://repo.msys2.org/msys/x86_64/pacman-6.0.1-15-x86_64.pkg.tar.zst -o $TEMP/pacman.tar.zst
curl -k https://repo.msys2.org/msys/x86_64/pacman-mirrors-20220205-1-any.pkg.tar.zst -o $TEMP/pacman-mirrors.tar.zst
curl -k https://repo.msys2.org/msys/x86_64/msys2-keyring-1~20220623-1-any.pkg.tar.zst -o $TEMP/msys2-keyring.tar.zst
tar --use-compress-program=unzstd -xvf $TEMP/pacman.tar.zst
tar --use-compress-program=unzstd -xvf $TEMP/pacman-mirrors.tar.zst
tar --use-compress-program=unzstd -xvf $TEMP/msys2-keyring.tar.zst

curl -k https://raw.githubusercontent.com/git-for-windows/build-extra/main/git-for-windows-keyring/git-for-windows.gpg -o $TEMP/keyring.gpg
pacman-key --init
pacman-key --populate msys2
pacman-key --add $TEMP/keyring.gpg
pacman-key --lsign-key E8325679DFFF09668AD8D7B67115A57376871B1C
pacman-key --lsign-key 3B6D86A1BA7701CD0F23AED888138B9E1A9F3986

pacman --noconfirm --overwrite "*" -Syyuu
pacman --noconfirm --overwrite "*" -S base-devel mingw-w64-x86_64-toolchain
pacman --noconfirm --overwrite "*" -S autotools curl gtk-doc texinfo
