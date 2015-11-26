#!/bin/bash



secret=`hexdump -e '16/1 "%02x " "\n"' /dev/urandom | head -1 | sed 's/ //g'`
echo $secret

dir=/tmp/ulrk

mkdir $dir

cat rk-unalias.sh | sed "s/SECRET_PLACEHOLDER/$secret/" >  $dir/rk-unalias.sh
chmod +x $dir/rk-unalias.sh

cat rk-alias.sh | sed "s/SECRET_PLACEHOLDER/$secret/" > $dir/rk-alias.sh
chmod +x $dir/rk-alias.sh

cp rk-sudo.sh $dir/rk-sudo.sh
chmod +x $dir/rk-sudo.sh

cp ulrkrc $dir/.ulrkrc

echo "source $dir/.ulrkrc" >> ~/.bashrc

echo "secret: $secret"


