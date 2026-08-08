#!/bin/bash

if [ ! -f "/var/www/html/wp-config.php" ]; then

    DB_PASS=$(cat /run/secrets/db_password)

    source /run/secrets/credentials

    wp core download --allow-root

    wp config create --dbname="${db_name}" --dbuser="${db_user}" --dbpass="${DB_PASS}" --dbhost="mariadb" --allow-root

    wp core install --url="${DOMAIN_NAME}" --title="Inception" --admin_user="${WP_ADMIN}" --admin_password="${WP_ADMIN_PASS}" --admin_email="${WP_ADMIN_EMAIL}" --allow-root

    wp user create "${WP_USER}" "${WP_USER_EMAIL}" --user_pass="${WP_USER_PASS}" --role=author --allow-root
fi

exec php-fpm8.2 -F
