#!/bin/bash


x=$BASH_COMMAND

echo "running command: $x";
this_command=`HISTTIMEFORMAT= history 1 | sed -e "s/^[ ]*[0-9]*[ ]*//"`;
echo "or $this_command"

exit

