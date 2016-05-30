FROM alpine
RUN apk update && \
	apk upgrade && \
	apk add apache2 apache2-ssl php-apache2 && \
	apk add php php-openssl php-pdo php-dom php-opcache php-xml php-json php-phar php-pear php-zip php-mysql php-pgsql ca-certificates && \
	rm /var/cache/apk/*
WORKDIR /var/www/html
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" && \
	php -r "if (hash_file('SHA384', 'composer-setup.php') === '92102166af5abdb03f49ce52a40591073a7b859a86e8ff13338cf7db58a19f7844fbc0bb79b2773bf30791e935dbd938') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;" && \
	php composer-setup.php && \
	php -r "unlink('composer-setup.php');" && \
	mv composer.phar /usr/local/bin/composer && \
	#composer global require "laravel/installer" && \
	rm -rf /etc/apache2/conf.d/ssl.conf && \
	mkdir -p /run/apache2
ADD config/httpd-laravel.conf /etc/apache2/conf.d/httpd-laravel.conf
ADD config/entrypoint.sh entrypoint.sh
RUN chmod u+x entrypoint.sh
EXPOSE 80
ENTRYPOINT ["./entrypoint.sh"]
