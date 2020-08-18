# AlpineDroid

Alpine Linux chroot environment for your Android smart device.

## Requirements
- Root
- Busybox
- Brain

## Installation
```
adb connect x.x.x.x
adb push setup.sh /sdcard
adb shell su -c 'sh /sdcard/setup.sh'
```

## How to use?
Bind required partitions
`./data/alpinedroid/up.sh`
Chroot into the alpine environment
`./data/alpinedroid/chroot.sh`
Unmount partions (careful "/sdcard" is bound to /data/alpinedroid/mnt/sdcard by default you don't want to loose any data by doing "rm -rf /data/alpinedroid". Make sure it's unmounted!!!)
`./data/alpinedroid/down.sh`
