#!/bin/bash
sudo apt update
sudo apt upgrade -y
sudo apt install -y apache2
web_server_hostname=`hostname`
sudo echo "<h1>Web server $web_server_hostname</h1>" > /var/www/html/index.html