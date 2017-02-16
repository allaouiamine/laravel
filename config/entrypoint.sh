#!/bin/sh
#/root/.composer/vendor/bin/laravel new app
if [ -f /var/www/html/app/composer.json ]
then
  cd app 
  composer update
fi
chown -R apache:apache /var/www/html 
chmod -R 550 /var/www/html/
chmod -R 770 /var/www/html/app/storage 2> /dev/null
chmod -R 770 /var/www/html/app/bootstrap/cache 2> /dev/null
/usr/sbin/httpd -DFOREGROUND
