---
layout: post
title: "Archlinux 安装 bspwm"

---

装了 bspwm，方便简单，不需要太多的修改就能使用。

    yaourt bspwm-git sxhkd-git xdo-git xtitle-git clock-git feh rofi-git termite compton-git

sxhkd 定义快捷键，xdo、xtitle、clock 组成简单的 panel，feh 更换桌面背景、rofi 快捷启动器、compton 开启窗口特效。

bspwm 旧版和 git 版的某些配置语法不同，比如设置窗口的状态，所以要以 git 上的 Wiki 为准。

复制配置：

    cp /usr/share/doc/bspwm/examples/bspwmrc ~/.config/bspwm/
    cp /usr/share/doc/bspwm/examples/sxhkdrc ~/.config/sxhkd/
    cp -r /usr/share/doc/bspwm/examples/panel ~/.config/bspwm/

`.xinitrc` 写入 `exec bspwm`即可。一般的 Display Manager 会查 `/usr/share/xsessions/bspwm.desktop`，自动列出 bspwm session。

环境变量、预启动程序都可写入 `~/.config/bspwm/bspwmrc` ，启动时自动运行。

Java 程序白屏:

	export _JAVA_AWT_WM_NONREPARENTING=1

确保 QT4 和 QT5 都用 fcitx：

    export QT_IM_MODULE=fcitx

设置脱离了 plasma 的 QT5 应用主题，装 `qt5ct`，QT4 用 `qtconfig-qt4`：

    export QT_QPA_PLATFORMTHEME="qt5ct"

简单的 panel，须设环境变量和 PATH：

    export PATH=$HOME/.config/bspwm/panel:$PATH
    export PANEL_FIFO=/tmp/panel_fifo
    export PANEL_FONT=Monaco
    panel &

设置背景：

    feh --bg-scale $HOME/wallper.jpg

添加混合特效：

    compton -b

解决“X”指针，还要设置 `~/.icons/default/index.theme` 确保不同框架的程序表现一致：

    xsetroot -cursor_name left_ptr 

设置所有窗口为浮动：

    bspc rule -a "*" state=floating

`bspc rule` 为指定的窗口添加规则，用` xprop | grep WM_CLASS` 查找窗口类名，比如 Firefox：

    WM_CLASS(STRING) = "Navigator", "Firefox"

类名就是后面的“Firefox”，大小写敏感，设定规则：
    
    bspc rule -a Firefox desktop='^2' follow=on

始终在桌面2启动 Firefox，并切换到焦点。

要指定 desktop 下的所有 node 为浮动，添加脚本：

	#!/bin/bash

	# change the desktop number here
	FLOATING_DESKTOP_ID=$(bspc query -D -d '^2')

	bspc subscribe node_manage | while read -a msg ; do
	   desk_id=${msg[2]}
	   wid=${msg[3]}
	   [ "$FLOATING_DESKTOP_ID" = "$desk_id" ] && bspc node "$wid" -t floating
	   echo $FLOATING_DESKTOP_ID $desk_id $wid  >> /tmp/floatdesk.pid
	done

然后在 .xinitrc 或 bspwmrc 后台运行此脚本。已知的是 Emacs 有一定概率不浮动，添加个规则即可：

	bspc rule -a Emacs state=tiled