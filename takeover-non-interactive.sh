#!/bin/sh
set -e

TO=/takeover
OLD_INIT=$(readlink /proc/1/exe)
PORT=80

cd "$TO"

echo "[INFO] Starting non-interactive takeover..."

if [ ! -e fakeinit ]; then
    ./busybox echo "Please compile fakeinit.c first" 
    exit 1
fi

./busybox echo "[INFO] Setting up target filesystem..." 
./busybox rm -f etc/mtab
./busybox ln -s /proc/mounts etc/mtab
./busybox mkdir -p old_root

./busybox echo "[INFO] Mounting pseudo-filesystems..." 
./busybox mount -t tmpfs tmp tmp
./busybox mount -t proc proc proc
./busybox mount -t sysfs sys sys

if ! ./busybox mount -t devtmpfs dev dev; then
    ./busybox mount -t tmpfs dev dev
    ./busybox cp -a /dev/* dev/
    ./busybox rm -rf dev/pts
    ./busybox mkdir dev/pts
fi
./busybox mount --bind /dev/pts dev/pts

./busybox echo "[INFO] Skipping TTY setup (non-interactive mode)" 

./busybox echo "[INFO] Preparing new init..." 
./busybox cat >tmp/${OLD_INIT##*/} <<EOF
#!${TO}/busybox sh

# Non-interactive init
cd "${TO}"

./busybox echo "[INFO] Init takeover successful"
./busybox echo "[INFO] Pivoting root..."

./busybox mount --make-rprivate /
./busybox pivot_root . old_root

./busybox echo "[INFO] Chrooting and running fakeinit..."

exec ./busybox chroot . /fakeinit
EOF

./busybox chmod +x tmp/${OLD_INIT##*/}

./busybox echo "[INFO] Starting secondary sshd on port $PORT" 

./busybox chroot . /usr/bin/ssh-keygen -A
./busybox chroot . /usr/sbin/sshd -p $PORT -o PermitRootLogin=yes

./busybox echo "[INFO] New sshd is running." 
./busybox echo "[INFO] About to take over init..." 

./busybox mount --bind tmp/${OLD_INIT##*/} ${OLD_INIT}

./busybox echo "[INFO] Triggering telinit u" 
telinit u

./busybox echo "[INFO] Sleeping 10s for takeover..." 
./busybox sleep 10

./busybox echo "[INFO] Done. After takeover, reconnect to port $PORT." 
