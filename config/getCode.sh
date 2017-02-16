#!/bin/sh
git clone https://github.com/allaouiamine/app-cabinet-srv.git
mv app-cabinet-srv app
cd app 
composer update
chmod -R 770 /var/www/html/app/storage 
chmod -R 770 /var/www/html/app/bootstrap/cache
