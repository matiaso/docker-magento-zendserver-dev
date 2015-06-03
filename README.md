#Zendserver docker container for magento development

- 1) Build your container :
./build.sh

- 2) start your container :
./run-server.sh \<instance_name\> \<url\>

The \<instance_name\> will be your docker container name. It will be use for the magento installation.
The \<url\> is your the url used in your database to access the website. http://<url>, the url will be added to your /etc/host file

Be carefull to not have an apache2 or mysql running in the same  time (the ports 80 et 3306 must be free).

- 3) Where can i edit the files ?
Before starting, put a bdd.sql file into the directory:
/data/\<instance_name\>/mysql/bdd.sql
Then add your magento files into 
/data/\<instance_name\>/html/

Once started the file will be in the folder /data/\<instance_name\>/
- The database file will be in /data/\<instance_name\>/mysql/
- The magento file will be in /data/\<instance_name\>/html/

