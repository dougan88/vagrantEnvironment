#!/usr/bin/env bash
mysql -uroot -proot -e "CREATE DATABASE IF NOT EXISTS wp01;CREATE USER wp01@localhost IDENTIFIED BY 'sqlinj123';GRANT ALL PRIVILEGES ON wp01.* TO wp01@localhost;FLUSH PRIVILEGES;"