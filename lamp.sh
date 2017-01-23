#!/usr/bin/env bash

sudo apt-get update
sudo apt-get install apache2 -y

sudo add-apt-repository ppa:ondrej/php

sudo apt-get update -y

sudo apt-get install php7.0 -y 
sudo apt-get install php7.0-mysql -y



sudo mkdir /vagrant/www
# echo "
# <?php phpinfo(); ?>" > /vagrant/www/index.php


echo "<VirtualHost *:80>
	ServerName wp01
	ServerAlias www.wp01.loc
	DocumentRoot /vagrant/www
	<Directory /vagrant/www/>
		Options Indexes FollowSymLinks
		AllowOverride None
		Require all granted
	</Directory>
	ErrorLog /var/log/apache2/wp01.log
	LogLevel warn
	CustomLog /var/log/apache2/wp01-custom.log combined
</VirtualHost>
" >> /etc/apache2/sites-available/wp01.conf

echo "
127.0.0.1 wp01"  >> /etc/hosts

sudo a2ensite wp01.conf
sudo service apache2 restart


# Adding configuration for pdo virtual host

sudo mkdir /vagrant/pdo
sudo mkdir /vagrant/pdo/www
echo "
<?php phpinfo(); ?>" > /vagrant/pdo/www/index.php


sudo echo "<VirtualHost *:80>
	ServerName pdo
	ServerAlias www.pdo.loc
	DocumentRoot /vagrant/pdo/www
	<Directory /vagrant/pdo/www/>
		Options Indexes FollowSymLinks
		AllowOverride None
		Require all granted
	</Directory>
	ErrorLog /var/log/apache2/pdo.log
	LogLevel warn
	CustomLog /var/log/apache2/pdo-custom.log combined
</VirtualHost>
" >> /etc/apache2/sites-available/pdo.conf

echo "
127.0.0.1 pdo"  >> /etc/hosts

sudo a2ensite pdo.conf
sudo service apache2 restart

#endconf

# Adding configuration for php research

sudo mkdir /vagrant/php
sudo mkdir /vagrant/php/www
echo "
<?php phpinfo(); ?>" > /vagrant/php/www/index.php


sudo echo "<VirtualHost *:80>
	ServerName php
	ServerAlias www.php.loc
	DocumentRoot /vagrant/php/www
	<Directory /vagrant/php/www/>
		Options Indexes FollowSymLinks
		AllowOverride None
		Require all granted
	</Directory>
	ErrorLog /var/log/apache2/php-site.log
	LogLevel warn
	CustomLog /var/log/apache2/php-custom.log combined
</VirtualHost>
" >> /etc/apache2/sites-available/php.conf

echo "
127.0.0.1 php"  >> /etc/hosts

sudo a2ensite php.conf
sudo service apache2 restart

#endconf

# Adding configuration for symfony msp project

#sudo mkdir /vagrant/msp


sudo echo "<VirtualHost *:80>
	ServerName msp
	ServerAlias www.msp.loc
	DocumentRoot /vagrant/msp/web
	<Directory /vagrant/msp/web/>
		Options Indexes FollowSymLinks
		AllowOverride None
		Require all granted
	</Directory>
	ErrorLog /var/log/apache2/php-site.log
	LogLevel warn
	CustomLog /var/log/apache2/php-custom.log combined
</VirtualHost>
" >> /etc/apache2/sites-available/msp.conf

sudo echo "<VirtualHost *:80>
    ServerName msp
    ServerAlias www.msp.loc

    DocumentRoot /vagrant/msp/web
    <Directory /vagrant/msp/web>
        AllowOverride None
        Order Allow,Deny
        Allow from All

        <IfModule mod_rewrite.c>
            Options -MultiViews
            RewriteEngine On
            RewriteCond %{REQUEST_FILENAME} !-f
            RewriteRule ^(.*)$ app.php [QSA,L]
        </IfModule>
    </Directory>

    <Directory /vagrant/msp/web/bundles>
        <IfModule mod_rewrite.c>
            RewriteEngine Off
        </IfModule>
    </Directory>
    ErrorLog /var/log/apache2/project_error.log
    CustomLog /var/log/apache2/project_access.log combined
</VirtualHost>
" >> /etc/apache2/sites-available/msp.conf

sudo echo "<VirtualHost *:80>
    ServerName msp
    ServerAlias www.msp.loc

    DocumentRoot /var/www/msp/web
    <Directory /var/www/msp/web>
        AllowOverride All
        Order Allow,Deny
        Allow from All
    </Directory>

    ErrorLog /var/log/apache2/msp_error.log
    CustomLog /var/log/apache2/msp_access.log combined
</VirtualHost>
" >> /etc/apache2/sites-available/msp.conf

echo "
127.0.0.1 msp"  >> /etc/hosts

sudo a2ensite msp.conf
sudo service apache2 restart

#endconf

export DEBIAN_FRONTEND=noninteractive
sudo -E apt-get -q -y install mysql-server
mysqladmin -u root password root
sudo mysql_install_db


sudo apt-get update
sudo apt-get install -y php5-gd libssh2-php
sudo apt-get install -y php7.0-gd

sudo apt-get install php7.0-xdebug
sudo echo '\n zend_extension="/usr/lib/php/20121212/xdebug.so"' >> /etc/php/7.0/apache2/php.ini
sudo sed -i 's/display_errors = Off/display_errors = On/g' /etc/php/7.0/apache2/php.ini

#install mbstring
sudo apt-get install php7.0-mbstring -y

sudo service apache2 restart

#installing composer
curl -sS https://getcomposer.org/installer | php
sudo mv composer.phar /usr/local/bin/composer

#installing git
sudo apt-get install git -y
git config --global user.name "Eugene Yurkov"
git config --global user.email "dougan888@gmail.com"
