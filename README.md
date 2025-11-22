## takeover


### non-interactive
```
mkdir -p /takeover
mount -t tmpfs tmpfs /takeover
wget https://github.com/mlyxshi/takeover/releases/download/x86_64/alpine-takeover-rootfs.tar.gz
tar -xvf alpine-takeover-rootfs.tar.gz -C /takeover
cd /takeover && wget https://raw.githubusercontent.com/mlyxshi/takeover/refs/heads/main/takeover-non-interactive.sh
sh /takeover/takeover-non-interactive.sh
```

### interactive
```
mkdir -p /takeover
mount -t tmpfs tmpfs /takeover
wget https://github.com/mlyxshi/takeover/releases/download/x86_64/alpine-takeover-rootfs.tar.gz
tar -xvf alpine-takeover-rootfs.tar.gz -C /takeover
cd /takeover && wget https://raw.githubusercontent.com/mlyxshi/takeover/refs/heads/main/takeover.sh
sh /takeover/takeover.sh
```