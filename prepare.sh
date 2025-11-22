#!/bin/sh

mkdir /takeover
mount -t tmpfs tmpfs /takeover
cd /
wget https://github.com/LloydAsp/templates/releases/download/v1.0.0/alpine-takeover.tar.gz
tar -xvf alpine-takeover.tar.gz

mkdir -p /takeover/root/.ssh
chmod 700 /takeover/root/.ssh
echo "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMpaY3LyCW4HHqbp4SA4tnA+1Bkgwrtro2s/DEsBcPDe" > /takeover/root/.ssh/authorized_keys
chmod 600 /takeover/root/.ssh/authorized_keys
