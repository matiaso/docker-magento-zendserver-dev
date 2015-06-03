from ubuntu 

RUN apt-get update 
RUN DEBIAN_FRONTEND=noninteractive apt-get -y dist-upgrade 
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y vim php5 php5-cli git curl expect mysql-server mysql-client unzip

RUN apt-key adv --keyserver pgp.mit.edu --recv-key 799058698E65316A2E7A4FF42EAE1437F7D2C623
RUN echo "deb http://repos.zend.com/zend-server/8.0.2/deb_apache2.4 server non-free" >> /etc/apt/sources.list.d/zend-server.list
RUN DEBIAN_FRONTEND=noninteractive apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y libapache2-mod-php-5.5-zend-server zend-server-php-5.5
RUN DEBIAN_FRONTEND=noninteractive /usr/local/zend/bin/zendctl.sh stop

RUN sed -i -e"s/^bind-address\s*=\s*127.0.0.1/bind-address = 0.0.0.0/" /etc/mysql/my.cnf

ADD ./000-default.conf /etc/apache2/sites-available/000-default.conf
ADD ./startup.sh /usr/local/bin/startup.sh
RUN chmod +x /usr/local/bin/startup.sh

expose 80
expose 3306
EXPOSE 10081 
EXPOSE 10082

VOLUME ["/var/www/magento"]
VOLUME ["/var/lib/mysql"]

CMD ["/bin/bash","/usr/local/bin/startup.sh"]
