#! /usr/bin/env bash

if [ "$1" == "c" ]; then
    #git config --global --edit
    #git commit --amend --reset-author
    git config --global user.email "none"
    git config --global user.name "none"
fi
git add .
git commit -m "update"
git push origin master
