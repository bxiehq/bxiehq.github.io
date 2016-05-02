#! /usr/bin/env bash

F=`date +%F`-`echo $1 | tr ' ' -`.md
set -x
touch  _posts/$F
set +x

cat > _posts/$F << EOF
---
layout: post
title: ""
---
EOF
