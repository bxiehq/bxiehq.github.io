---
layout: post
title:  "Jekyll 显示数学公式"
mjlatex: true
date:   2016-04-19 17:02:22 +0800
categories: jekyll update
---

许多个人博客都是用 MathJax 实现对数学公式的支持，一般都在主题模板上外部引用 MathJax 的脚本，稍作配置即可使用，简单方便。
相较于 Ghost、Wordpress， 用 Kramdown 引擎的 Jekyll 对 MathJax 的支持更方便，在公式内无需用下标转义。

Kramdown 自动将一对双美元符号「$$」里的内容放入「math/tex」类型的 script 标签内。 MathJax 看到这个标签就自动渲染成单行公式。

$$ N < f(x) < M \Leftrightarrow [ f(x)-M ][ f(x)-N] < 0 \\
                \Leftrightarrow | f(x)-\frac{M+N}{2} | < \frac{M-N}{2}  \\
                \Leftrightarrow \frac{f(x)-N}{M-f(x)}>0 $$

看源代码就是翻译成了：

```
<script type="math/tex; mode=display">% <![CDATA[
N < f(x) < M \Leftrightarrow [ f(x)-M ][ f(x)-N] < 0 \\
                \Leftrightarrow | f(x)-\frac{M+N}{2} | < \frac{M-N}{2}  \\
                \Leftrightarrow \frac{f(x)-N}{M-f(x)}>0 %]]></script>
```

当然你在源文件里用 script 标签的形式写也是可行的：

<script type="math/tex; mode=display">\complement_U(A\bigcap B) = \complement_UA\bigcup \complement_UB; \complement_U(A\bigcup B) = \complement_UA\bigcap \complement_UB</script>

Kramdown 对一对单美元符号「$」的内容也一样，不做翻译，也不换行，所以 MathJax 见到了就显示成行内公式：

像这样： $ m = \gamma m_0 = \frac{m_0}{\sqrt{1-v^2/c^2}} $

另外还有一个 math 标签，里面须是 MathML 语法才能正常显示，否则 MathJax 报错。

找一个模板文件，加入下面的代码就行了：

```
{% raw %}
<head>
...
{% if page.latex == true %}
     <script type="text/javascript" src="//cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-MML-AM_HTMLorMML">
     </script>
{% endif %}
...
</head>
{% endraw %}
```

默认 MathJax 关闭了「$」内的公式显示，需要设置。如果想用 AsciiMath， 我试了一下，要把配置的那段放在 body 内：

```
{% raw %}
<body>
...
{% if page.latex == true %}
   <script type="text/x-mathjax-config">
       MathJax.Hub.Config({ tex2jax: { inlineMath: [ ['$', '$'], ['\\(', '\\)'] ] } });
   </script>
{% endif %}
...
</body>
{% endraw %}
```

默认 AsciiMath 放在一对「\`」符号内， Kramdown 里面需要转义：

\` sum_(i=1)^n i^3=((n(n+1))/2)^2 \`

写文章的时候，文件头加入 `latex: true` 就会自动包含 MathJax 脚本。 
