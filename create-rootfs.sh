#!/bin/sh

BASE_URL="https://dl-cdn.alpinelinux.org/alpine/latest-stable/releases/x86_64/"
FILENAME=$(curl -s "$BASE_URL" \
           | grep -oP 'alpine-minirootfs-[0-9]+\.[0-9]+\.[0-9]+-x86_64\.tar\.gz' \
           | sort -V \
           | tail -n1)
DOWNLOAD_URL="${BASE_URL}${FILENAME}"
echo "Download URL: $DOWNLOAD_URL"

wget "$DOWNLOAD_URL" -O /tmp/alpine-minirootfs.tar.gz
mkdir -p /tmp/takeover-rootfs

tar -xvf alpine-minirootfs.tar.gz -C /tmp/takeover-rootfs

mkdir -p /tmp/takeover-rootfs/root/.ssh
chmod 700 /tmp/takeover-rootfs/root/.ssh
echo "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMpaY3LyCW4HHqbp4SA4tnA+1Bkgwrtro2s/DEsBcPDe" > /tmp/takeover-rootfs/root/.ssh/authorized_keys
chmod 600 /tmp/takeover-rootfs/root/.ssh/authorized_keys

cd /tmp/takeover-rootfs/
wget 

tar -czvf alpine-takeover-rootfs .
