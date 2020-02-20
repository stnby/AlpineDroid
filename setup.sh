#!/system/bin/sh
ROOTFS="http://dl-cdn.alpinelinux.org/alpine/v3.11/releases/aarch64/alpine-minirootfs-3.11.3-aarch64.tar.gz"
DEST="/data/alpine"

DNS1="1.1.1.1"
DNS2="1.0.0.1"

set -e

echo "< prepare"
mkdir -p $DEST
cd $DEST
echo "> prepare"

echo "< download rootfs"
busybox wget -c $ROOTFS -O rootfs.tar.gz
echo "> download rootfs"

echo "< extract rootfs"
busybox tar -xf rootfs.tar.gz
rm rootfs.tar.gz
echo "> extract rootfs"

echo "> configure"
mkdir -p mnt/sdcard
echo "nameserver $DNS1
nameserver $DNS2" > etc/resolv.conf
echo "#!/system/bin/sh -e
busybox mount -t proc none $DEST/proc
busybox mount --rbind /sys $DEST/sys
busybox mount --rbind /dev $DEST/dev
busybox mount --rbind /sdcard $DEST/mnt/sdcard" > up.sh
echo "#!/system/bin/sh
busybox umount $DEST/proc
busybox umount $DEST/sys
busybox umount -l $DEST/dev
busybox umount $DEST/mnt/sdcard" > down.sh
echo "#!/system/bin/sh
busybox chroot $DEST /bin/sh" > chroot.sh
chmod +x {up,down,chroot}.sh
echo "< configure"
