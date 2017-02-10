#!/bin/sh
#/root/.composer/vendor/bin/laravel new app
#cd app 
#composer update 
chown -R apache:apache /var/www/html 
chmod -R 550 /var/www/html/ 
chmod -R 770 /var/www/html/app/storage 
chmod -R 770 /var/www/html/app/bootstrap/cache
/usr/sbin/httpd -DFOREGROUND
