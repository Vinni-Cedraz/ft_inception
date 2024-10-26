FROM alpine:3.19.4

ARG PHP_VERSION=82 \
    DB_NAME \
    DB_USER \
    DB_PASS \
    DOMAIN_NAME

RUN apk update && apk upgrade && apk add --no-cache \
    php${PHP_VERSION} \
    php${PHP_VERSION}-fpm \
    php${PHP_VERSION}-mysqli \
    php${PHP_VERSION}-json \
    php${PHP_VERSION}-curl \
    php${PHP_VERSION}-dom \
    php${PHP_VERSION}-exif \
    php${PHP_VERSION}-fileinfo \
    php${PHP_VERSION}-mbstring \
    php${PHP_VERSION}-openssl \
    php${PHP_VERSION}-xml \
    php${PHP_VERSION}-zip \
    php${PHP_VERSION}-pecl-redis \
    mariadb-client \
    wget \
    unzip && \
    sed -i "s|listen = 127.0.0.1:9000|listen = 9000|g" \
      /etc/php82/php-fpm.d/www.conf && \
    sed -i "s|;listen.owner = nobody|listen.owner = nobody|g" \
      /etc/php82/php-fpm.d/www.conf && \
    sed -i "s|;listen.group = nobody|listen.group = nobody|g" \
      /etc/php82/php-fpm.d/www.conf && \
    rm -f /var/cache/apk/*

# Install WP-CLI
RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x wp-cli.phar && \
    mv wp-cli.phar /usr/local/bin/wp

WORKDIR /var/www

# Copy WordPress files
RUN wget https://wordpress.org/latest.zip && \
    unzip latest.zip && \
    cp -rf wordpress/* . && \
    rm -rf wordpress latest.zip

# Copy configuration scripts
COPY ./requirements/wordpress/conf/wp-config-create.sh .
COPY ./requirements/wordpress/conf/wordpress-setup.sh .

RUN chmod +x wp-config-create.sh wordpress-setup.sh && \
    sh wp-config-create.sh && \
    rm wp-config-create.sh && \
    chmod -R 0777 wp-content/

ENTRYPOINT ["sh", "wordpress-setup.sh"]
