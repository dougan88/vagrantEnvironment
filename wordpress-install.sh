#!/usr/bin/env bash

cd ~
wget http://wordpress.org/latest.tar.gz
tar xzvf latest.tar.gz

sudo rsync -avP ~/wordpress/ /vagrant/www-wp-engine/
#sudo cp /vagrant/wp-config.php /vagrant/www/wp-config.php

# sudo chown -R vagrant:www-data *
# sudo mkdir /vagrant/www/wp-content/uploads
# sudo chown -R :www-data /vagrant/www/wp-content/uploads