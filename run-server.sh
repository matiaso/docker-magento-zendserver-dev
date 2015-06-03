#!/bin/sh
if [ "$#" -ne 2 ]; then
    echo "Illegal number of parameters use run-server.sh <instance_name> <url_access>"
    return;
fi

#rm -rf /data/$1

docker stop $1
docker rm $1
docker run --name $1 --env BASE_URL="$2" --env SITE_NAME="$1" -v /data/$1/mysql/:/var/lib/mysql -v /data/$1/html/:/var/www/html pierrefay/zendserver-dev-magento

MYHOST="$2"

cp /etc/hosts /etc/hosts_sav

sed -i -e "/$1/d" /etc/hosts
CONTAINER_ID=$(docker ps | grep "$1 "| awk '{print $1}')
IP=$(docker inspect --format '{{ .NetworkSettings.IPAddress }}' $CONTAINER_ID)

echo "$IP www.$1.lan"
echo "$IP www.$1.lan" >> /etc/hosts

echo "Deploying Docker container $1 (http://$MYHOST/) ! Please wait..."

sleep 350

echo "Container $1 (http://$MYHOST/) started !!"

echo "Server logs - [ctrl + d] to stop :"
tail -f /data/$1/html/logs-server.log

