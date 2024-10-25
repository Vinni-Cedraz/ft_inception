#!/bin/sh

# Wait for MySQL to be ready
until wp core install --path=/var/www \
    --url=https://vcedraz-.42.fr \
    --title="WordPress Site" \
    --admin_user=admin \
    --admin_password=adminpassword \
    --admin_email=admin@example.com \
    --skip-email; do
    echo "Waiting for MySQL..."
    sleep 2
done

# Start PHP-FPM
exec /usr/sbin/php-fpm82 -F
