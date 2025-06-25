FROM debian:bullseye

RUN apt-get update
RUN apt-get upgrade
RUN apt-get -y install wget
RUN apt-get install -y php7.4 php-fpm php-mysql mariadb-client
RUN wget https://fr.wordpress.org/wordpress-6.8.1-fr_FR.tar.gz -P /var/www
RUN tar -xvf /var/www/wordpress-6.8.1-fr_FR.tar.gz -C /var/www
RUN	chown -R root:root /var/www/wordpress
RUN chown -R 777 /var/www/wordpress

RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar -O /usr/local/bin/wp-cli.phar
RUN chmod 777 /usr/local/bin/wp-cli.phar


COPY config.sh /config.sh
RUN chmod +x /config.sh

COPY ./www.conf /etc/php/7.4/fpm/pool.d/www.conf
RUN chmod 644 /etc/php/7.4/fpm/pool.d/www.conf

RUN mkdir -p /run/php && chown -R www-data:www-data /run/php


CMD ["/config.sh"]
