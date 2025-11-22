#!/bin/sh

mkdir -p /takeover
mount -t tmpfs tmpfs /takeover
wget https://github.com/mlyxshi/takeover/releases/download/x86_64/alpine-takeover-rootfs.tar.gz
tar -xvf alpine-takeover-rootfs.tar.gz -C /takeover
