---
layout: post
title: "红米 Note 3 安装 Cyanogenmod 13"
description: "redmi note 3, cyanogenmod, firmware, rom"

---

千元 Note 3（高通的 CPU），是目前能支持 CM 的最便宜的手机了。自带的 MIUI 全 TM 广告，完全没法用，遂弃之，取 CM，刷之，记下步骤。

## 刷开发版

有卡刷和线刷两种，不过卡刷从来没成功，提示：

> 更新包验证失败,无法正常更新

于是放弃，改线刷。到 [http://www.miui.com/shuaji-393.html]() 下载通用刷机工具和完整包，注意是全网通版。通用刷机工具设置有个脚本名要改成完整包里的名字，目录选择在完整包根文件夹下。

关机，按住`减音量+电源`进入 fastboot。刷新、刷机。


## 解锁、刷 recovery

- 申请地址：http://www.miui.com/unlock/，登陆、手机号、理由，审核10分钟左右；
- 手机进入 fastboot 模式；
- 安装[解锁工具](http://www.miui.com/unlock/done.html)，登录、解锁

下载 [twrp](https://twrp.me/)，fastboot flash：

    fastboot flash recovery twrp_kenzo.img
    fastboot boot twrp_kenzo.img  # 这步重要，否则出现充电图

## Firmware, Cyanogenmod, OpenGApps

按住`音量加+电源`进 recovery，先清除分区，可保留 SD 卡和 Internal Storage。先刷固件，只需一次，否则设置内 VPN、锁屏崩溃，指纹不可用。如果安装 OpenGApps，可选 CM nightly，首次启动时跳过 Google 服务器的验证。