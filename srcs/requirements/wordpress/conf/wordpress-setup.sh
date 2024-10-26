#!/bin/sh

# Wait for MariaDB to be ready
while ! mysqladmin ping -h"mariadb" --silent; do
    echo "Waiting for database connection..."
    sleep 3
done

if ! wp core is-installed --path=/var/www --allow-root; then
    # Install WordPress
    wp core install \
        --path=/var/www \
        --url="https://${DOMAIN_NAME}" \
        --title="WordPress Site" \
        --admin_user="admin" \
        --admin_password="admin123" \
        --admin_email="admin@${DOMAIN_NAME}" \
        --skip-email \
        --allow-root
fi

exec /usr/sbin/php-fpm82 -F
