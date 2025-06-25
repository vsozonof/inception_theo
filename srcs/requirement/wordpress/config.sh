#!/bin/bash

echo "listen = 9000" >> /etc/php/7.4/fpm/pool.d/www.conf
echo "clear_env = no" >> /etc/php/7.4/fpm/pool.d/www.conf

until mysql -hmariadb -u$SQL_USR -p$SQL_PASS -e "SHOW DATABASES;" > /dev/null 2>&1; do
    echo "En attente du lancement de MariaDB..."
    sleep 15
done

if [ ! -f "/var/www/wordpress/wp-config.php" ]; then
    wp-cli.phar config create --allow-root \
        --dbname=$SQL_DB \
        --dbuser=$SQL_USR \
        --dbpass=$SQL_PASS \
        --dbhost=mariadb:3306 --path='/var/www/wordpress'
fi

if ! wp-cli.phar core is-installed --allow-root --path='/var/www/wordpress'; then
	wp-cli.phar core install --url="$WP_URL" --title="$WP_TITLE" --admin_user="$WP_USER" --admin_password="$WP_PASS" --admin_email="$WP_MAIL" --path='/var/www/wordpress' --allow-root
fi

if ! wp-cli.phar user get $WP_USR2 --allow-root --path='/var/www/wordpress'; then
    wp-cli.phar user create $WP_USR2 $WP_MAIL2 --user_pass=$WP_PASS2 --role=administrator --path='/var/www/wordpress' --allow-root
fi


exec php-fpm7.4 -F