#!/bin/bash


SECRET="SECRET_PLACEHOLDER"


echo "in unalias"
if [[ $1 = $SECRET ]];
then
    # unalias the second command
    shopt $SECRET -u expand_aliases
    unalias $2
    #shopt $SECRET -s expand_aliases
    shopt -s expand_aliases # expand aliases is currently off
else
    echo 'unalias: na'
fi
