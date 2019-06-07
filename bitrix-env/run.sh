#!/bin/sh
trap "shut_down" HUP INT QUIT KILL TERM

shut_down(){

service nginx stop
service httpd stop
service sshd stop
service crond stop
service memcached stop

}

cp -f /usr/share/zoneinfo/$TIMEZONE /etc/localtime
echo "127.0.0.1 $DOMAIN" >> /etc/hosts

service crond start
service httpd start
service nginx start
service sshd start
service memcached start

echo "bitrix:$SSH_PASS" | chpasswd

while true; do sleep 1; done

shut_down

echo "exited $0"