#! /bin/bash

KEYNAME=lacson@vt.edu

mkdir /tmp/gpg
sudo mount -t ramfs -o size=1M ramfs /tmp/gpg
sudo chown $(logname):$(logname) /tmp/gpg
gpg --export-secret-subkeys $KEYNAME > /tmp/gpg/subkeys

gpg --delete-secret-key lacson@vt.edu

gpg --import /tmp/gpg/subkeys
sudo umount /tmp/gpg
rmdir /tmp/gpg
