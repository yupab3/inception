#!/bin/sh
set -e

cd /var/www/html

if wp core download is-installed --path=/var/www/html --allow-root; then
else
    wp config create --dbname=${WORDPRESS_DB_NAME} --dbuser=${MYSQL_USER} --dbpass=${MYSQL_PASSWORD} --dbhost=${MYSQL_HOST} --allow-root

    wp core install --url="$WP_URL" --title="$WP_TITLE" --admin_user="$WP_ADMIN_USER" --admin_password="$WP_ADMIN_PASSWORD" --admin_email="$WP_ADMIN_EMAIL" --allow-root
    wp user create "$WP_GENERAL_USER" "$WP_GENERAL_EMAIL" --role=subscriber --user_pass="$WP_GENERAL_PASSWORD" --allow-root

    wp option update blogdescription "hiiiiiiiii" --allow-root
    wp option update timezone_string "Korea/Gaepo" --allow-root
    wp option update date_format "Y-m-d" --allow-root
    wp option update time_format "H:i" --allow-root
    wp option update permalink_structure "/%postname%/" --allow-root

    # if [ -z "omg" ]; then
    adduser --disabled-password omg
    # fi

    chown -R omg:omg /var/www/html
fi

exec php-fpm82 -F