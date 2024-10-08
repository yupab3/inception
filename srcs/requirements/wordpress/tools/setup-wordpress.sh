#!/bin/sh
set -e

cd /var/www/html

if wp core is-installed --path=/var/www/html --allow-root; then
    echo "Already done"
else
    wp core download --path=/var/www/html --allow-root
    wp config create --dbname=${WORDPRESS_DB_NAME} --dbuser=${MYSQL_USER} --dbpass=${MYSQL_PASSWORD} --dbhost=${MYSQL_HOST} --allow-root

    wp core install --url="$WP_URL" --title="$WP_TITLE" --admin_user="$WP_ADMIN_USER" --admin_password="$WP_ADMIN_PASSWORD" --admin_email="$WP_ADMIN_EMAIL" --allow-root
    wp user create "$WP_GENERAL_USER" "$WP_GENERAL_EMAIL" --role=subscriber --user_pass="$WP_GENERAL_PASSWORD" --allow-root

fi

adduser --disabled-password wordpress

chown -R wordpress:wordpress /var/www/html
chmod -R 755 /var/www/html

exec php-fpm82 -F