#!/bin/sh
#/root/.composer/vendor/bin/laravel new app
if [ -f /var/www/html/app/composer.json ]
then
  cd app 
  composer update
  chmod -R 770 /var/www/html/app/storage 
  chmod -R 770 /var/www/html/app/bootstrap/cache
fi
chown -R apache:apache /var/www/html 
chmod -R 550 /var/www/html/ 
/usr/sbin/httpd -DFOREGROUND
