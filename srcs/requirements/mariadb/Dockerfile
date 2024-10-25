FROM alpine:3.19.4

ARG DB_NAME \
    DB_USER \
    DB_PASS \
    DB_ROOT

RUN apk update && apk add --no-cache mariadb mariadb-client

# Create directories and set permissions
RUN mkdir -p /var/run/mysqld /var/lib/mysql && \
    chown -R mysql:mysql /var/run/mysqld /var/lib/mysql && \
    chmod 777 /var/run/mysqld

# Configure MariaDB
RUN { echo '[mysqld]'; \
      echo 'skip-host-cache'; \
      echo 'skip-name-resolve'; \
      echo 'bind-address=0.0.0.0'; \
      echo 'user=mysql'; \
      echo 'datadir=/var/lib/mysql'; \
      echo 'port=3306'; \
    } | tee /etc/my.cnf.d/docker.cnf && \
    sed -i "s|skip-networking|skip-networking=0|g" \
      /etc/my.cnf.d/mariadb-server.cnf

# Initialize database
RUN mysql_install_db --user=mysql --datadir=/var/lib/mysql --skip-test-db && \
    chown -R mysql:mysql /var/lib/mysql

EXPOSE 3306

COPY requirements/mariadb/conf/create_db.sh .
RUN chmod +x create_db.sh && \
    chown mysql:mysql create_db.sh && \

USER mysql

VOLUME ["/var/lib/mysql"]

CMD ["mysqld", "--user=mysql", "--console"]
