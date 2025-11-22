#!/bin/sh

BASE_URL="https://dl-cdn.alpinelinux.org/alpine/latest-stable/releases/x86_64/"
FILENAME=$(curl -s "$BASE_URL" | grep -oP 'alpine-minirootfs-[0-9]+\.[0-9]+\.[0-9]+-x86_64\.tar\.gz' | sort -V | tail -n1)
DOWNLOAD_URL="${BASE_URL}${FILENAME}"
echo "Download URL: $DOWNLOAD_URL"

wget "$DOWNLOAD_URL" -O /tmp/alpine-minirootfs.tar.gz
mkdir -p /tmp/takeover-rootfs

tar -xf /tmp/alpine-minirootfs.tar.gz -C /tmp/takeover-rootfs

cd /tmp/takeover-rootfs

mkdir -p ./root/.ssh
chmod 700 ./root/.ssh
echo "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMpaY3LyCW4HHqbp4SA4tnA+1Bkgwrtro2s/DEsBcPDe" > ./root/.ssh/authorized_keys
chmod 600 ./root/.ssh/authorized_keys

echo "nameserver 1.1.1.1" > ./etc/resolv.conf

wget https://github.com/mlyxshi/takeover/raw/refs/heads/main/pre-build/busybox
wget https://github.com/mlyxshi/takeover/raw/refs/heads/main/pre-build/fakeinit

chmod +x ./busybox ./fakeinit

chroot . apk add openssh

tar -czf /tmp/alpine-takeover-rootfs.tar.gz .