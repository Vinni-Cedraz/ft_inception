FROM alpine:3.19.4

ARG PHP_VERSION=php82 \
    DB_NAME \
    DB_USER \
    DB_PASS \
    DOMAIN_NAME \
	ADMIN \
	ADMIN_PASS \
	USER2 \
	USER2_PASS

RUN apk update && apk upgrade && apk add --no-cache \
	${PHP_VERSION} \
    ${PHP_VERSION}-fpm \
    ${PHP_VERSION}-mysqli \
    ${PHP_VERSION}-json \
    ${PHP_VERSION}-curl \
    ${PHP_VERSION}-dom \
    ${PHP_VERSION}-exif \
    ${PHP_VERSION}-fileinfo \
    ${PHP_VERSION}-mbstring \
    ${PHP_VERSION}-openssl \
    ${PHP_VERSION}-xml \
    ${PHP_VERSION}-zip \
    ${PHP_VERSION}-phar \
    mariadb-client \
    wget \
    unzip && \
    sed -i "s|listen = 127.0.0.1:9000|listen = 9000|g" \
      /etc/php82/php-fpm.d/www.conf && \
    rm -f /var/cache/apk/*

WORKDIR /var/www

# Copy WordPress files
RUN wget https://wordpress.org/latest.zip && \
    unzip latest.zip && \
    cp -rf wordpress/* . && \
    rm -rf wordpress latest.zip

# Install WP-CLI
RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x wp-cli.phar && \
    mv wp-cli.phar /usr/local/bin/wp

# Copy configuration scripts
COPY ./requirements/wordpress/conf/wp-config-create.sh .
COPY ./requirements/wordpress/conf/wordpress-setup.sh .

RUN chmod +x wp-config-create.sh wordpress-setup.sh && \
    sh wp-config-create.sh && \
    rm wp-config-create.sh && \
    chmod -R 0777 wp-content/

ENTRYPOINT ["sh", "wordpress-setup.sh"]
