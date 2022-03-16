#!/bin/sh

SSH_CONFIG=$HOME/.ssh/config

if test -f $SSH_CONFIG; then
    for i in `grep "^HOST " $SSH_CONFIG | sed s/"^HOST "// | grep -v "^\*$"`
    do
        echo "${i}"
    done
fi
