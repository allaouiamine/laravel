FROM alpine
RUN addgroup -g 100000 apache
RUN adduser -G apache -h /var/www/html -s /sbin/nologin -S -D -H -u 100000 apache
RUN apk update && \
	apk upgrade && \
	apk add apache2 apache2-ssl php5-apache2 wget && \
	apk add git mariadb-clients php5 php5-openssl php5-pdo php5-dom php5-opcache php5-xml php5-json php5-phar php5-pear php5-zip php5-mysql php5-pgsql ca-certificates && \
	rm /var/cache/apk/*
RUN	mkdir /var/www/html
WORKDIR /var/www/html
RUN EXPECTED_SIGNATURE=$(wget -q -O - https://composer.github.io/installer.sig) && \
	php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" && \
	ACTUAL_SIGNATURE=$(php -r "echo hash_file('SHA384', 'composer-setup.php');") && \
	[ "$EXPECTED_SIGNATURE" == "$ACTUAL_SIGNATURE" ] && \
	php composer-setup.php --quiet && \
	rm -rf composer-setup.php && \
	mv composer.phar /usr/local/bin/composer
RUN	mkdir -p /run/apache2
ADD config/httpd-laravel.conf /etc/apache2/conf.d/httpd-laravel.conf
ADD config/entrypoint.sh entrypoint.sh
RUN chmod u+x entrypoint.sh
EXPOSE 80
ENTRYPOINT ["./entrypoint.sh"]
