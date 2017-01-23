#!/usr/bin/env bash

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
