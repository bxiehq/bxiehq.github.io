#! /usr/bin/env bash

F=`date +%F`-`echo $1 | tr ' ' -`.md
set -x
touch  _posts/$F
