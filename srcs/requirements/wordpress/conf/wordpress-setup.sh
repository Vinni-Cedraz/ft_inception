#!/bin/bash

# Wait for MySQL to be ready
for i in {1..30}; do
    if mysqladmin ping -h"mariadb" -u"${DB_USER}" -p"${DB_PASS}" --silent; then
        echo "[WORDPRESS SETUP] Database connection successful!" >&2
        break
    fi
    echo "[WORDPRESS SETUP] Waiting for database connection... ($i/30)" >&2
    sleep 2
done

# Check WordPress installation
echo "[WORDPRESS SETUP] Checking if WordPress is installed..." >&2
wp core is-installed --path=/var/www --allow-root
WP_INSTALLED=$?

if [ $WP_INSTALLED -ne 0 ]; then
    echo "[WORDPRESS SETUP] WordPress is not installed. Installing now..." >&2
    
    wp core install \
        --path=/var/www \
        --url="https://${DOMAIN_NAME}" \
        --title="Inception WordPress Website" \
        --admin_user="hello_world" \
        --admin_password="acb99dfsj39o" \
        --admin_email="mail@example.com" \
        --skip-email \
        --allow-root \
        --debug

    INSTALL_RESULT=$?
    if [ $INSTALL_RESULT -ne 0 ]; then
        echo "[WORDPRESS SETUP] ERROR: Installation failed with code ${INSTALL_RESULT}" >&2
        if [ -f /var/www/wp-content/debug.log ]; then
            echo "[WORDPRESS SETUP] Debug log contents:" >&2
            cat /var/www/wp-content/debug.log >&2
        fi
    else
        echo "[WORDPRESS SETUP] WordPress installed successfully!" >&2
    fi
else
    echo "[WORDPRESS SETUP] WordPress is already installed" >&2
fi

# Ensure there are two users in the WordPress application
echo "[WORDPRESS SETUP] Ensuring there are two users in the WordPress application..." >&2
wp user create second_user second_user@example.com --role=subscriber --user_pass=second_user_password --path=/var/www --allow-root

echo "[WORDPRESS SETUP] Starting PHP-FPM..." >&2
exec /usr/sbin/php-fpm82 -F
