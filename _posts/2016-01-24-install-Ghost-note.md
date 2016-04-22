---
layout: post
title:  "Ghost 的安装及配置"
---
## 官方推荐 0.10.x 版 NodeJS：

```
curl --silent --location https://deb.nodesource.com/setup_0.10 | sudo bash -
apt-get install --yes nodejs
```

## 下载解压：

    curl -L https://ghost.org/zip/ghost-latest.zip -o ghost.zip
    unzip -uo ghost.zip -d ghost

## 安装：

    cd ghost
    npm install --production

如果内存过小， npm 会被 kill。

    npm start

`CTRL+c` 终止服务，在根目录下生成 `config.js`，修改 url 为自己的域名。如果协议是 https 则会强制跳转。

## 后台运行+开机自启

`npm start` 监听 `http://127.0.0.1:2368/`，外网一般无法访问，所以用 nginx 中转; 同时也要保证该服务始终运行，安装 forever;如果让它开机启动，安装 supervisor：

```
npm install forever -g
apt-get install --yes nginx
apt-get install --yes supervisor
```

forever:

```
NODE_ENV=production forever start index.js #开始进程
forever stop index.js #停止进程
forever list  # 列出进程
```

环境变量为 production，否则文章显示不出来。

supervisor:

修改 `/etc/supervisor/conf.d/ghost.conf`

```
[program:ghost]
command = node /path/to/index.js
directory = /path/to
autostart = true
autorestart = true
stdout_logfile = /var/log/supervisor/ghost.log
stderr_logfile = /var/log/supervisor/ghost_err.log
environment = NODE_ENV="production"
```

```
service supervisor restart # 启动服务
supervisorctl start ghost # 启动服务
```

nginx:

修改 `/etc/nginx/sites-available/default`

```
server {
    listen	80;
    server_name example.com;

    location / {
        proxy_set_header X-Real-IP  $remote_addr;
        proxy_set_header X-Forwarded-For $remote_addr;
        proxy_set_header Host $host;
        proxy_pass http://127.0.0.1:2368;
    }

    location ~* \.(?:ico|css|js|gif|jpe?g|png|ttf|woff)$ {
        access_log off;
        expires 30d;
        add_header Pragma public;
        add_header Cache-Control "public, mustrevalidate, proxy-revalidate";
        proxy_pass http://127.0.0.1:2368;
    }

    location = /robots.txt { access_log off; log_not_found off; }
    location = /favicon.ico { access_log off; log_not_found off; }

    location ~ /\.ht {
            deny all;
    }
}
```

`service nginx restart` 重启即可。

如果加了层 CloudFlare，只允许该厂的 IP 访问，加入 `location /`：

```
allow 103.21.244.0/22;
allow 103.22.200.0/22;
allow 103.31.4.0/22;
allow 104.16.0.0/12;
allow 108.162.192.0/18;
allow 141.101.64.0/18;
allow 162.158.0.0/15;
allow 172.64.0.0/13;
allow 173.245.48.0/20;
allow 188.114.96.0/20;
allow 190.93.240.0/20;
allow 197.234.240.0/22;
allow 198.41.128.0/17;
allow 199.27.128.0/21;
deny all;
```

## 注册帐号

`http://yoursite.com/ghost/setup/` 注册管理员帐号。

## 设置邮件

主要用来找回密码，到 https://mailgun.com/app/dashboard 注册个账户，默认有个 Sandbox Domain，将账户密码填充到 config.js:

```
mail: {
   transport: 'SMTP',
   options: {
       service: 'Mailgun',
       auth: {
           user: '', // mailgun username
           pass: ''  // mailgun password
       }
   }

```
注意用户名不能包含空格。

## MathJax 支持

编辑 `content/themes/casper/default.hbs`，在 `</head>` 前加入：

```
{{! Mathjax configuration}}
<script type="text/javascript"    src="//cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-AMS-MML_HTMLorMML"></script>

<script type="text/x-mathjax-config">  
    MathJax.Hub.Config({  
        tex2jax: {inlineMath: [['$','$'], ['\\(','\\)']],
                  displayMath: [['$$','$$'], ['\[','\]']]}
    });
</script>  

```

注意公式内下标符号「`_`」要用转义「`\_`」。

## 参考：

https://ttt.tt/161/

http://damowang.net/blog/2015/12/19/install-ghost-on-ubuntu/

http://blog.mollywhite.net/how-to-display-mathematical-equations-in-ghost/
