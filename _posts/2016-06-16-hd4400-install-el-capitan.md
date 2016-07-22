---
layout: post
title: "Intel HD4400 安装 OS X 10.11 El Capitan"

---


装黑苹果的笔记，做个记录。所碰到的问题只在自己的机型上碰到过，不同硬件出现的情况不尽相同。但大部分问题都可以在远景、tonymacx86、insanelymac 找到解决方法。

首先用 UEFI＋GPT 方案安装。OS X 和 Clover 支持这种方案，省时省力。UEFI 的可启动 USB 硬盘制作起来要简单得多，不必对付 MBR 什么的 。

有两种方法制作启动优盘。一是到各大论坛下载带 Clover 的 USB 原版镜像或者是懒人版，然后用 Transmac 刻录到优盘。或是直接装个虚拟机[^1]，以内置命令 `createinstallmedia` 安装[^2]。

一般到这时候，如果插在 Mac 上是可以直接安装的，但普通电脑不行。所以这时候 Clover 的作用就体现出来了，它就是一个 Bootloader，让 OS X 认为这就是一台真的 Mac。如果是 USB 镜像或是懒人包，应该 Clover 是装好了的，更改 `config.plist` 就差不多。如果是在虚拟机下或者真机，装个 [Clover 安装向导](https://sourceforge.net/projects/cloverefiboot/files/latest/download)就行[^3]。

安装完成后，搜索关键字 `显卡型号 config.plist` 来找合适的 `config.plist`。一般到最后你都会找到 RehabMan 这个人的配置：https://github.com/RehabMan/OS-X-Clover-Laptop-Config。之后装几个最基本的驱动：FakePCIID.kext、FakeSMC.kext、VoodooPS2Controller.kext 等。具体怎么装，不同显卡、网卡、系统版本各不相同，通过关键字 `显卡型号＋10.11或者 El Capian`来找。安装驱动的时候要看说明，注意哪些额外模块是需要加载的。比如说我的显卡是 HD4400，就下载 `config_HD4600_4400_4200.plist`，重命名为 `config.plist` 。该配置禁用了 VBoxHfs.efi，需要把这一条删了，要不然到时候看不到 OS X 的启动菜单。根据关键字 `HD4400 10.11` 找到：http://www.tonymacx86.com/threads/fix-hd4200-hd4400-hd4600-hd5600-on-10-11.175797/，按上面的步骤操作基本上能成功。值得一提的是 VBoxHFS.efi 和 HFSPlus.efi，两者都可以用来读取 HFS 分区，被 Clover 用来寻找可引导的项，据说后者速度快，但前者兼容性好，如果出现启动黑屏的现象就用前者[^4]。

在安装阶段只用 Fake ID、显卡、键盘的驱动，在将系统安装到硬盘之后再安装网卡、声卡、电源的驱动到 `/System/Library/Extensions`，方法也和上面一样，模块型号＋系统版本。个人经验，除了 VoodooPS2Controller，其它的只需放在 EFI/Clover/kexts。

一般，安装完毕之后主要需要解决电源、声卡和睡眠的问题。电源须打 DSDT 补丁，不过本人个例无法显示电源状态，始终是100％；声卡装的是 [AppleALC](https://github.com/vit9696/AppleALC)，设定声卡 Layout ID，**并在 DSDT 或 Clover 中修复 HPET 和 HDA**，也可能需修复显卡驱动的 glitch 问题（ config.plist 里有，但默认是禁用的，启用适合系统的版本），不然外部声音和耳机可能无法自动切换；睡眠不怎么用，不过据说有些机型不能实现，也就懒得搞了，碰到过黑屏之后无法唤醒显示器的情况，关闭屏保就行。

总而言之，目前运行状况大体不影响日常使用。已知的问题有某些 fn 组合键无效、无法唤醒、长时间待机无法关闭电源。目前还没找到解决方法，以后想到了再补充。 

不过得说说 RehanMan 这个人，据说此人是个 lengend，而且人品极佳[^5]，基本上所有黑苹果需要的驱动都是他写的。不仅如此，他还常年混迹 tonymacx86，对于小白的各种提问，都是有问必答有求必应，可谓人类公仆、宇宙楷模，实乃黑苹果届的活雷锋，建议不懂的朋友多多向他提问请教。

[^1]: https://kat.cr/os-x-10-11-el-capitan-vmware-image-t11386865.html
[^2]: https://support.apple.com/en-us/HT201372
[^3]: http://www.tonymacx86.com/threads/how-to-install-os-x-yosemite-using-clover.144426/
[^4]: https://www.reddit.com/r/hackintosh/comments/4a7hhl/whats_the_difference_between_vboxhfs64efi_and/
[^5]: https://www.reddit.com/r/hackintosh/comments/3r26bq/question_who_is_rehabman_and_why_does_he_have_to/