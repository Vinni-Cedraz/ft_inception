#!/bin/bash

echo "[WORDPRESS SETUP] Starting setup script..." >&2

# Wait for MySQL to be ready
for i in {1..30}; do
    if mysqladmin ping -h"mariadb" -u"${DB_USER}" -p"${DB_PASS}" --silent; then
        echo "[WORDPRESS SETUP] Database connection successful!" >&2
        break
    fi
    echo "[WORDPRESS SETUP] Waiting for database connection... ($i/30)" >&2
    sleep 2
done

# Print environment variables (excluding password)
echo "[WORDPRESS SETUP] DOMAIN_NAME=${DOMAIN_NAME}" >&2
echo "[WORDPRESS SETUP] DB_NAME=${DB_NAME}" >&2
echo "[WORDPRESS SETUP] DB_USER=${DB_USER}" >&2

# Check WordPress installation
echo "[WORDPRESS SETUP] Checking if WordPress is installed..." >&2
wp core is-installed --path=/var/www --allow-root
WP_INSTALLED=$?

if [ $WP_INSTALLED -ne 0 ]; then
    echo "[WORDPRESS SETUP] WordPress is not installed. Installing now..." >&2
    
    wp core install \
        --path=/var/www \
        --url="https://${DOMAIN_NAME}" \
        --title="WordPress Site" \
        --admin_user="admin" \
        --admin_password="admin123" \
        --admin_email="admin@example.com" \
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

echo "[WORDPRESS SETUP] Starting PHP-FPM..." >&2
exec /usr/sbin/php-fpm82 -F
