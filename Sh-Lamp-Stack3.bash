#!/bin/bash
###Ubuntu 20.04
if [[ $(lsb_release -rs) == "20.04" ]]; then
sudo timedatectl set-timezone Asia/Kolkata
log=lamp-stack-$(date +"%d-%m-%Y").txt
printf "Log File - " > $log
date >> $log
(
echo " Current Instance is Ubuntu 20.04 "
sudo apt install -y net-tools
sudo apt install software-properties-common -y
echo "y" | sudo add-apt-repository ppa:ondrej/php
var1="apache2"
var2="mysql-client"
var3="php7.2"
var4="libapache2-mod-php7.2"
var5="redis-server"
var6="php7.2-redis"
echo "system updating"
sudo apt-get update
sudo apt install -y $var1
sudo systemctl start $var1
sudo systemctl enable $var1
sudo apt install -y $var2
sudo apt install -y $var3
sudo apt install -y $var4
sudo apt install -y $var5
sudo apt install -y $var6
echo " Installed Required software "
echo "y" | sudo ufw enable
sudo ufw allow 22/tcp
sudo ufw allow 80/tcp
sudo ufw allow 443/tcp
sudo ufw allow 6379/tcp
sudo chmod  o+w /var/www/html
sudo chmod -R 755 /var/www/html
sudo chown -R www-data:www-data /var/www/html
sudo cat > /var/www/html/info.php <<- EOF
<?php
phpinfo ();
phpinfo (INFO_MODULES);
?>
EOF
sudo sed -i  's/Options Indexes FollowSymLinks/Options FollowSymLinks/g' /etc/apache2/apache2.conf
sudo sed -i '/<Directory \/var\/www\/>/,/<\/Directory>/ s/AllowOverride None/AllowOverride All/' /etc/apache2/apache2.conf
sudo a2enmod rewrite
configtestResult=$(sudo apachectl configtest 2>&1)
 if  [ "$configtestResult" == "Syntax OK" ]; then
    sudo systemctl restart $var1
        echo " Apache Restarted "
 else
        echo " Please Check config file"
 fi
)2>&1 >> $log
sudo cp lamp-stack-$(date +"%d-%m-%Y").txt /var/log/
fi
###Ubuntu 18.04
if [[ $(lsb_release -rs) == "18.04" ]]; then
sudo timedatectl set-timezone Asia/Kolkata
sudo apt install make -y
sudo apt install -y net-tools 
sudo apt install -y git
log=lamp-stack-$(date +"%d-%m-%Y").txt
printf "Log File - " > $log
date >> $log
(
echo " ubuntu version is  18.04"
var1="apache2"
var2="mysql-client"
var3="php7.2"
var4="libapache2-mod-php7.2"
var5="redis-server"
var6="php7.2-redis"
echo "system updating"
sudo apt-get update
sudo apt install -y $var1
sudo systemctl start $var1
sudo systemctl enable $var1
sudo apt install -y $var2
sudo apt install -y $var3
sudo apt install -y $var4
sudo apt install -y $var5
sudo apt install -y $var6
sudo apt install -y php-dev
sudo git clone https://github.com/phpredis/phpredis.git
cd phpredis/
phpize
./configure
sudo make
sudo make install
echo "extension=redis.so" > /etc/php/7.2/mods-available/redis.ini
echo " Installed Required software "
echo "y" | sudo ufw enable
sudo ufw allow 22/tcp
sudo ufw allow 80/tcp
sudo ufw allow 443/tcp
sudo ufw allow 6379/tcp
sudo chmod  o+w /var/www/html
sudo chmod -R 755 /var/www/html
sudo chown -R www-data:www-data /var/www/html
sudo cat > /var/www/html/info.php <<- EOF
<?php
phpinfo ();
phpinfo (INFO_MODULES);
?>
EOF
sudo sed -i  's/Options Indexes FollowSymLinks/Options FollowSymLinks/g' /etc/apache2/apache2.conf
sudo sed -i '/<Directory \/var\/www\/>/,/<\/Directory>/ s/AllowOverride None/AllowOverride All/' /etc/apache2/apache2.conf
sudo a2enmod rewrite
configtestResult=$(sudo apachectl configtest 2>&1)
 if  [ "$configtestResult" == "Syntax OK" ]; then
    sudo systemctl restart $var1
        echo " Apache Restarted "
 else
        echo " Please Check config file"
 fi
)2>&1 >> $log
sudo cp lamp-stack-$(date +"%d-%m-%Y").txt /var/log/
fi
###Ubuntu 16.04
if [[ $(lsb_release -rs) == "16.04" ]]; then
sudo timedatectl set-timezone Asia/Kolkata
log=lamp-stack-$(date +"%d-%m-%Y").txt
printf "Log File - " > $log
date >> $log
(
echo " ubuntu version is  16.04"
sudo apt-get install -y make
sudo apt-get install -y git
sudo apt-get install -y net-tools
sudo apt-get install software-properties-common python-software-properties
echo "yes" | sudo add-apt-repository ppa:ondrej/php
var1="apache2"
var2="mysql-client"
var3="php"
var4="libapache2-mod-php"
var5="redis-server"
var6="php-redis"
sudo apt-get update
sudo apt install -y $var1
sudo systemctl start $var1
sudo systemctl enable $var1
sudo apt install -y $var2
sudo apt install -y $var3
sudo apt install -y $var4
sudo apt install -y $var5
sudo apt install -y $var6
sudo apt install -y php-dev
sudo git clone https://github.com/phpredis/phpredis.git
cd phpredis/
phpize
./configure
sudo make
sudo make install
echo "extension=redis.so" > /etc/php/7.0/mods-available/redis.ini
echo " Installed Required software "
echo "y" | sudo ufw enable
sudo ufw allow 22/tcp
sudo ufw allow 80/tcp
sudo ufw allow 443/tcp
sudo ufw allow 6379/tcp
sudo chmod  o+w /var/www/html
sudo chmod -R 755 /var/www/html
sudo chown -R www-data:www-data /var/www/html
sudo cat > /var/www/html/info.php <<- EOF
<?php
phpinfo ();
phpinfo (INFO_MODULES);
?>
EOF
sudo sed -i  's/Options Indexes FollowSymLinks/Options FollowSymLinks/g' /etc/apache2/apache2.conf
sudo sed -i '/<Directory \/var\/www\/>/,/<\/Directory>/ s/AllowOverride None/AllowOverride All/' /etc/apache2/apache2.conf
sudo a2enmod rewrite
configtestResult=$(sudo apachectl configtest 2>&1)
 if  [ "$configtestResult" == "Syntax OK" ]; then
    sudo systemctl restart $var1
        echo " Apache Restarted "
 else
        echo " Please Check config file"
 fi
)2>&1 >> $log
sudo cp lamp-stack-$(date +"%d-%m-%Y").txt /var/log/
fi
###Centos 8
if [[ $(rpm --eval %{centos_ver}) == "8" ]]; then
sudo timedatectl set-timezone Asia/Kolkata
sudo yum install wget -y
sudo yum install -y net-tools
sudo yum install -y git
log=lamp-stack-$(date +"%d-%m-%Y").txt
printf "Log File - " > $log
date >> $log
(
echo " Current Instance is CenOS 8 "
sudo yum install firewalld -y
sudo systemctl enable firewalld
sudo systemctl restart firewalld
sudo firewall-cmd --zone=public --add-port=22/tcp
sudo firewall-cmd --zone=public --add-port=80/tcp
sudo firewall-cmd --zone=public --add-port=443/tcp
sudo firewall-cmd --zone=public --add-port=6379/tcp
sudo firewall-cmd --add-service=http --permanent
var1="httpd"
var2="mysql-server"
var3="php"
var4="redis"
var5="php-devel"
sudo yum update -y
echo "system updated"
sudo yum install -y $var1
sudo systemctl start $var1
sudo systemctl enable $var1
sudo yum install -y $var2
sudo systemctl start mysqld
sudo yum install -y $var3
sudo yum install -y $var4
sudo systemctl start $var4
sudo systemctl enable $var4
sudo yum install -y $var5
sudo yum install -y make
sudo git clone https://github.com/phpredis/phpredis.git
cd phpredis/
phpize
./configure
sudo make
sudo make install
echo "extension=redis.so" > /etc/php.ini
sudo chmod  o+w /var/www/html
sudo chmod -R 755 /var/www/html
sudo chown -R apache:apache /var/www/html
sudo cat > /var/www/html/info.php <<- EOF
<?php
phpinfo ();
phpinfo (INFO_MODULES);
?>
EOF
sudo sed -i  's/Options Indexes FollowSymLinks/Options FollowSymLinks/g' /etc/httpd/conf/httpd.conf
sudo sed -i '/<Directory "\/var\/www\/html">/,/<\/Directory>/ s/AllowOverride None/AllowOverride All/' /etc/httpd/conf/httpd.conf
sudo cat > /var/www/html/.htaccess <<- EOF
RewriteEngine On
EOF
configtestResult=$(sudo apachectl configtest 2>&1)
 if  [ "$configtestResult" == "Syntax OK" ]; then
    sudo systemctl restart $var1
        echo " Apache Restarted "
 else
        echo " Please Check config file"
 fi		
)2>&1 >> $log
sudo cp lamp-stack-$(date +"%d-%m-%Y").txt /var/log/
  if [[ $(getenforce) == "Disabled" ]]; then
    sudo sed -i 's/SELINUX=disabled/SELINUX=permissive/' /etc/selinux/config
	reboot
  fi
  if [[ $(getenforce) == "Enforcing" ]]; then
    sudo sed -i 's/SELINUX=enforcing/SELINUX=permissive/' /etc/selinux/config
	reboot
  fi
fi
###Centos 7
if [[ $(rpm --eval %{centos_ver}) == "7" ]]; then
sudo timedatectl set-timezone Asia/Kolkata
sudo yum install wget -y
sudo yum install -y net-tools
log=lamp-stack-$(date +"%d-%m-%Y").txt
printf "Log File - " > $log
date >> $log
(
echo " Current Instance is CenOS 7 "
sudo yum install firewalld -y
sudo systemctl enable firewalld
sudo systemctl restart firewalld
sudo firewall-cmd --zone=public --add-port=22/tcp
sudo firewall-cmd --zone=public --add-port=80/tcp
sudo firewall-cmd --zone=public --add-port=443/tcp
sudo firewall-cmd --zone=public --add-port=6379/tcp
sudo firewall-cmd --add-service=http --permanent
var1="httpd"
var2="mysql-server"
var3="php"
var4="redis"
var5="php-redis"
sudo yum install epel-release yum-utils -y
sudo yum install http://rpms.remirepo.net/enterprise/remi-release-7.rpm -y
sudo yum-config-manager --enable remi-php72
sudo yum update -y
echo "system updated"
sudo yum install -y $var1
sudo systemctl start $var1
sudo systemctl enable $var1
wget https://dev.mysql.com/get/mysql57-community-release-el7-9.noarch.rpm
sudo rpm -ivh mysql57-community-release-el7-9.noarch.rpm
sudo yum install -y $var2
sudo systemctl start mysqld
sudo yum install -y $var3
sudo yum-config-manager --enable remi
sudo yum install -y $var4
sudo systemctl start $var4
sudo systemctl enable $var4
sudo yum install -y $var5
echo " Installed Required software "
sudo chmod  o+w /var/www/html
sudo chmod -R 755 /var/www/html
sudo chown -R apache:apache /var/www/html
sudo cat > /var/www/html/info.php <<- EOF
<?php
phpinfo ();
phpinfo (INFO_MODULES);
?>
EOF
sudo sed -i  's/Options Indexes FollowSymLinks/Options FollowSymLinks/g' /etc/httpd/conf/httpd.conf
sudo sed -i '/<Directory "\/var\/www\/html">/,/<\/Directory>/ s/AllowOverride None/AllowOverride All/' /etc/httpd/conf/httpd.conf
sudo cat > /var/www/html/.htaccess <<- EOF
RewriteEngine On
EOF
configtestResult=$(sudo apachectl configtest 2>&1)
 if  [ "$configtestResult" == "Syntax OK" ]; then
    sudo systemctl restart $var1
        echo " Apache Restarted "
 else
        echo " Please Check config file"
 fi		
)2>&1 >> $log
sudo cp lamp-stack-$(date +"%d-%m-%Y").txt /var/log/
 if [[ $(getenforce) == "Disabled" ]]; then
    sudo sed -i 's/SELINUX=disabled/SELINUX=permissive/' /etc/selinux/config
	reboot
 fi
 if [[ $(getenforce) == "Enforcing" ]]; then
    sudo sed -i 's/SELINUX=enforcing/SELINUX=permissive/' /etc/selinux/config
	reboot
 fi
fi
###CentOS 6,6.5,6.9
if [[ $(rpm --eval %{centos_ver}) == "6" ]]; then
sudo yum install -y system-config-date
sudo cat > /etc/sysconfig/clock <<- EOF
ZONE="Asia/Kolkata"
EOF
tzdata-update
log=lamp-stack-$(date +"%d-%m-%Y").txt
printf "Log File - " > $log
date >> $log
(
echo " Current Instance is CenOS 6 "
sudo yum install firewalld -y
sudo systemctl enable firewalld
sudo systemctl restart firewalld
sudo firewall-cmd --zone=public --add-port=22/tcp
sudo firewall-cmd --zone=public --add-port=80/tcp
sudo firewall-cmd --zone=public --add-port=443/tcp
sudo firewall-cmd --zone=public --add-port=6379/tcp
sudo firewall-cmd --add-service=http
sudo timedatectl set-timezone Asia/Kolkata
sudo yum install wget -y
sudo yum install -y net-tools
sudo yum install -y make
sudo yum install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-6.noarch.rpm
sudo yum install -y http://rpms.remirepo.net/enterprise/remi-release-6.rpm
rpm -Uvh http://download.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm
wget https://dl.fedoraproject.org/pub/epel/epel-release-latest-6.noarch.rpm
wget http://rpms.remirepo.net/enterprise/remi-release-6.rpm
rpm -Uvh remi-release-6.rpm epel-release-latest-6.noarch.rpm
sudo yum install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
sudo yum install -y https://rpms.remirepo.net/enterprise/remi-release-7.rpm
sudo yum install -y yum-utils
yum install -y --enablerepo=remi-php72 php php-cli
var1="httpd"
var2="mysql-server"
var3="php"
var4="redis"
var5="php-redis"
sudo yum update -y
echo "system updated"
sudo yum install -y $var1
sudo service httpd start
sudo service httpd  enable
sudo yum install -y $var2
sudo service  mysqld start
sudo yum install -y $var3
sudo yum install -y $var4
sudo service redis  start
sudo service redis  enable
sudo yum install php-pear php-devel
pecl install igbinary igbinary-devel redis
echo " Installed Required software "
sudo chmod  o+w /var/www/html
sudo chmod -R 755 /var/www/html
sudo chown -R apache:apache /var/www/html
sudo cat > /var/www/html/info.php <<- EOF
<?php
phpinfo ();
phpinfo (INFO_MODULES);
?>
EOF
sudo sed -i  's/Options Indexes FollowSymLinks/Options FollowSymLinks/g' /etc/httpd/conf/httpd.conf
sudo sed -i '/<Directory "\/var\/www\/html">/,/<\/Directory>/ s/AllowOverride None/AllowOverride All/' /etc/httpd/conf/httpd.conf
sudo cat > /var/www/html/.htaccess <<- EOF
RewriteEngine On
EOF
configtestResult=$(sudo apachectl configtest 2>&1)
 if  [ "$configtestResult" == "Syntax OK" ]; then
    sudo systemctl restart $var1
        echo " Apache Restarted "
 else
        echo " Please Check config file"
 fi		
)2>&1 >> $log
sudo cp lamp-stack-$(date +"%d-%m-%Y").txt /var/log/
  if [[ $(getenforce) == "Disabled" ]]; then
    sudo sed -i 's/SELINUX=disabled/SELINUX=permissive/' /etc/selinux/config
	reboot
  fi
  if [[ $(getenforce) == "Enforcing" ]]; then
    sudo sed -i 's/SELINUX=enforcing/SELINUX=permissive/' /etc/selinux/config
	reboot
  fi
fi