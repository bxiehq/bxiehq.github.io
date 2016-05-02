---
layout: post
mjlatex: true
title: "三角恒等式"
---

做个总结，基本上都来自[维基](https://en.wikipedia.org/wiki/List_of_trigonometric_identities)。

## 各种角：

![](https://upload.wikimedia.org/wikipedia/commons/4/4c/Unit_circle_angles_color.svg){:height="400px" width="400px"}

特殊角的值：

| 角度  | 弧度      | sin                    | cos                   | tan  |
| ---- |:---------:|:---------------------:|:---------------------:|:------------:|
| 15   |\`pi/12\`  |\`(sqrt(6)-sqrt(2))/4\`|\`(sqrt(6)+sqrt(2))/4\`|\`2-sqrt(3)\`
| 30   | \`pi/6 \` |\`1/2\`                |\`sqrt(3)/2\`          |\`sqrt(3)/3\`
| 45   | \`pi/4\`  |\`sqrt(2)/2\`          |\`sqrt(2)/2\`          |1
| 60   |\`pi/3\`   |\`sqrt(3)/2\`          |\`1/2\`                |\`sqrt(3)\`
| 90   |\`pi/2\`   |1                      |0                      |

## 勾股定理

\`sin^2theta + cos^2theta = 1\`

直角三角形中，\` a^2 + b^2 = c^2\`，是余弦定理 \` c^2 = a^2+b^2-2bc cos(gamma)\`的特殊情况。

逆定理：

- 如果\`a^2 + b^2 = c^2 \`，则△ABC是直角三角形。
- 如果\`a^2 + b^2 > c^2 \`，则△ABC是锐角三角形（若无先前条件AB=c为最长边，则该式的成立仅满足∠C是锐角）。
- 如果\`a^2 + b^2 < c^2 \`，则△ABC是钝角三角形。

## sin、cos、tan 等式

<https://en.wikipedia.org/wiki/List_of_trigonometric_identities#Related_identities>

## 对称、偏移、周期

诱导公式。有六种形式（关于2π的周期性、关于π的周期性、奇偶性、关于y轴的对称性、直角三角形的转换），可以统一成：

* $ \sin \left(\frac{k\pi }{2}\pm \alpha \right), k\in z $
* $ \cos \left(\frac{k\pi }{2}\pm \alpha \right), k\in z $
* $ \tan \left(\frac{k\pi }{2}\pm \alpha \right), k\in z $

口诀：「奇变偶不变，符号看象限」，当k为奇数时，sin变为cos，cos变为sin，tan变为cot，cot变为tan；而k为偶数时，三角函数则不变换。对于正负号，使用口诀：CAST 。

## 和差恒等式

$\sin(\alpha \pm \beta) = \sin \alpha \cos \beta \pm \cos \alpha \sin \beta $

$\cos(\alpha \pm \beta) = \cos \alpha \cos \beta \mp \sin \alpha \sin \beta $

$ \tan(\alpha \pm \beta) = \frac{\tan \alpha \pm \tan \beta}{1 \mp \tan \alpha \tan \beta} $

## 多倍角公式

二倍角：

$  \sin (2\theta) = 2 \cos \theta \sin \theta =\frac{2 \tan \theta} {1 + \tan^2 \theta} $

$  \cos (2\theta) = \cos^2 \theta - \sin^2 \theta = 2 \cos^2 \theta - 1 = 1 - 2 \sin^2 \theta = \frac{1 - \tan^2 \theta} {1 + \tan^2 \theta}
 $

$  \tan (2\theta) = \frac{2 \tan \theta} {1 - \tan^2 \theta} $

半角：

$ \sin \frac{\theta}{2} = \pm\, \sqrt{\frac{1 - \cos \theta}{2}} $

$ \cos \frac{\theta}{2} = \pm\, \sqrt{\frac{1 + \cos\theta}{2}} $

$ \begin{align} \tan \frac{\theta}{2} &= \csc \theta - \cot \theta \\ &= \pm\, \sqrt{1 - \cos \theta \over 1 + \cos \theta} \\ &= \frac{\sin \theta}{1 + \cos \theta} \\ &= \frac{1-\cos \theta}{\sin \theta} \\ &= \frac{\cos \theta+\sin \theta-1}{\cos \theta-\sin \theta+1} \end{align} $

其它：

$  \tan\frac{\eta+\theta}{2} = \frac{\sin\eta+\sin\theta}{\cos\eta+\cos\theta}  $

$  \tan\left( \frac{\alpha+\beta}{2} \right)
= \frac{\sin\alpha + \sin\beta}{\cos\alpha + \cos\beta}
= -\,\frac{\cos\alpha - \cos\beta}{\sin\alpha - \sin\beta} $

## 二次降幂

$ \sin^2\theta = \frac{1 - \cos (2\theta)}{2} $

$ \cos^2\theta = \frac{1 + \cos (2\theta)}{2} $

$ \sin^2\theta \cos^2\theta = \frac{1 - \cos (4\theta)}{8} $

## 积化和差、和差化积

积化和差：

$ 2\cos \theta \cos \varphi = { {\cos(\theta - \varphi) + \cos(\theta + \varphi)}} $

$ 2\sin \theta \sin \varphi = { {\cos(\theta - \varphi) - \cos(\theta + \varphi)} } $

$ 2\sin \theta \cos \varphi = { {\sin(\theta + \varphi) + \sin(\theta - \varphi)} } $

$ 2\cos \theta \sin \varphi = { {\sin(\theta + \varphi) - \sin(\theta - \varphi)} } $

$ \tan \theta \tan \varphi =\frac{\cos(\theta-\varphi)-\cos(\theta+\varphi)}{\cos(\theta-\varphi)+\cos(\theta+\varphi)} $

和差化积：

$ \sin \theta \pm \sin \varphi = 2 \sin\left( \frac{\theta \pm \varphi}{2} \right) \cos\left( \frac{\theta \mp \varphi}{2} \right) $

$ \cos \theta + \cos \varphi = 2 \cos\left( \frac{\theta + \varphi} {2} \right) \cos\left( \frac{\theta - $ \varphi}{2} \right) $

$ \cos \theta - \cos \varphi = -2\sin\left( {\theta + \varphi \over 2}\right) \sin\left({\theta - \varphi $ \over 2}\right) $

## 求面积

基本公式：\`S=1/2ah\`，已知两边一夹角：\`S=1/2ab sin(C)\`，已知边长及外接圆半径：\`S=(abc)/(4R)\`

## 总结：

- 余弦定理也适用于角：

> \` sin^2(alpha) = sin^2(beta)+sin^2(gamma)-2sin(beta)sin(gamma)cos(alpha)\`

- 一个三角形中，若给出包含 cos 和 sin 的边角等式，求边关系时，可用正弦定理将边转换为三角函数：

> （辽宁理4）△ABC的三个内角A，B，C所对的边分别为a，b，c，\` asinAsinB+bcos2A=sqrt(2)a \`，则 \`b/a = \`

- 三角形中若只包含边的等式，求 cos 的值时可用余弦定理：

> 在△ABC中，角A，B，C所对边长分别为a，b，c，若 \`a^2+b^2=2c^2\`，则 \`cos C\` 的最小值为（     ）

- 在三角形中，\`sin(2A)+sin(2B)+sin(2C)=4sin(A)sin(B)sin(C)\`, 三个角化为两个角，展开、提公因式、转换得到其中一角平方，再提公因式、变换得到第三个角的三角函数。
