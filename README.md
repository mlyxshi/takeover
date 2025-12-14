## takeover
https://github.com/marcan/takeover.sh

### build rootfs
x86_64 root
```
wget https://github.com/mlyxshi/takeover/raw/refs/heads/main/create-rootfs.sh
bash create-rootfs.sh
```

```
scp root@IP:/tmp/alpine-takeover-rootfs.tar.gz .
```


### non-interactive
```
mkdir -p /takeover
mount -t tmpfs tmpfs /takeover
wget https://dd.mlyxshi.com/alpine-takeover-rootfs.tar.gz
tar -xvf alpine-takeover-rootfs.tar.gz -C /takeover
sh /takeover/takeover-non-interactive.sh
```

### interactive
```
mkdir -p /takeover
mount -t tmpfs tmpfs /takeover
wget https://dd.mlyxshi.com/alpine-takeover-rootfs.tar.gz
tar -xvf alpine-takeover-rootfs.tar.gz -C /takeover
sh /takeover/takeover.sh
```