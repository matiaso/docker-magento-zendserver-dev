#!/bin/bash

#!/bin/bash

BDD_NAME=$SITE_NAME
BDD_HOST="localhost"

#/usr/sbin/service mysql start 
rm -f /var/www/html/index.html

if [ ! -e /var/lib/mysql/ibdata1 ]; then 	
	mysql_install_db
	/usr/bin/mysqld_safe &
	sleep 10s

	echo "GRANT ALL ON *.* TO pfay@'%' IDENTIFIED BY 'pfay123' WITH GRANT OPTION; FLUSH PRIVILEGES" | mysql -u root
	echo "DROP DATABASE IF EXISTS $BDD_NAME ;" | mysql -h $BDD_HOST -u root 
	echo "CREATE DATABASE $BDD_NAME" | mysql -h $BDD_HOST -u root

	echo "IMPORTING DATABASE..."
	mysql -h $BDD_HOST -u root $BDD_NAME < /var/lib/mysql/bdd.sql

	echo "MySql User and Permissions creation..."
	echo "GRANT ALL PRIVILEGES ON $BDD_NAME.* TO 'pfay'@'%' IDENTIFIED BY 'pfay123';" | mysql -h $BDD_HOST -u root

	#else
	#/usr/sbin/service mysql start
	#/usr/bin/mysqld_safe
fi

/usr/sbin/service mysql restart
echo "CLEAR CACHE AND SESSION..."
rm -rf /var/www/html/var/cache
rm -rf /var/www/html/var/session

echo "...Installation Complete !"

/usr/sbin/service zend-server restart  
tail -f /var/log/apache2/*.log > /var/www/html/logs-server.log
