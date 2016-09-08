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

`.xinitc` 写入 `exec bspwm`即可。一般的 Display Manager 会查 `/usr/share/xsessions/bspwm.desktop`，自动列出 bspwm session。

环境变量、预启动程序都可写入 `~/.config/bspwm/bspwmrc` ，启动时自动运行。

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

