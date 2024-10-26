#!/bin/bash

# Wait for MySQL to be ready - more robust check
for i in {1..30}; do
    if mysqladmin ping -h"mariadb" -u"${DB_USER}" -p"${DB_PASS}" --silent; then
        break
    fi
    echo "Waiting for database connection... ($i/30)"
    sleep 2
done

# Ensure wp-config.php has proper permissions
chmod 644 /var/www/wp-config.php

# Check if WordPress is already installed
if ! wp core is-installed --path=/var/www --allow-root; then
    echo "Installing WordPress..."
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

# Start PHP-FPM
exec /usr/sbin/php-fpm82 -F
