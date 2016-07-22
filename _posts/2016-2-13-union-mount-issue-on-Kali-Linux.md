---
layout: post
title:  "Union mount issue on Kali Linux 2016-1 live USB"
---

initrd.img of kali-linux-2016.1-amd64.iso is a little different in choosing default union mount driver. The newer version prefers `overlayfs` rather than `aufs` in older versions.

If use the old boot command line, a panic might occur during boot period like:

> Multiple lower filesystems are currently not supported with overlay

First extract the `initrd.img`. This file is combined by a normal and a gzipped cpio archive[^1]:

```
cpio -id < initrd.img
> 26 blocks  # first cpio occupied 512x26 bytes
dd if=initrd.img of=my.img.gz bs=512 skip=26
gzip -d my.img.gz
cpio -id < my.img

```
Then search the prompt string:

```
grep "Multiple lower filesystems are currently not supported with overlay" -R *
> bin/boot/9990-misc-helpers.sh:				panic "Multiple lower filesystems are currently not supported with overlay (unionro = ${unionro})."
> lib/live/boot/9990-misc-helpers.sh:				panic "Multiple lower filesystems are currently not supported with overlay (unionro = ${unionro})."
> Binary file my.img matches
```
Looking into `bin/boot/9990-misc-helpers.sh`:

```
1290     case "${UNIONTYPE}" in
1291         aufs)
...
1304             ;;
1305         
1306         overlay)
...
1323             ;;
1324     esac

```
Use grep to see where `UNIONTYPE` came from:

```
grep "UNIONTYPE="  -Rn *
> bin/boot/9990-cmdline-old:241:				UNIONTYPE="${_PARAMETER#union=}"
> bin/boot/9990-cmdline-old:269:		UNIONTYPE="overlay"
```

Gotcha:

```
240             union=*)
241                 UNIONTYPE="${_PARAMETER#union=}"
242                 export UNIONTYPE
...
267     if [ -z "${UNIONTYPE}" ]
268     then
269         UNIONTYPE="overlay"                                                 
270         export UNIONTYPE
271     fi

```

So all is clear, parameter `union=aufs` allows you choose preferred mount type.

PS: 2016-1 provides `/boot/grub/loopback.cfg` which let you create live USB drive easily. Just copy all content of ISO file, install GRUB, use command `configfiles /boot/grub/loopback.cfg` to get boot.

[^1]: http://unix.stackexchange.com/questions/163346/why-is-it-that-my-initrd-only-has-one-directory-namely-kernel
