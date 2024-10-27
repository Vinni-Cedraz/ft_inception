FROM alpine:3.19.4

RUN apk update && apk add --no-cache mariadb mariadb-client

RUN mkdir -p /var/run/mysqld && \
    chmod 777 /var/run/mysqld

RUN echo '[mysqld]' > /etc/my.cnf.d/docker.cnf && \
    echo 'skip-host-cache' >> /etc/my.cnf.d/docker.cnf && \
    echo 'skip-name-resolve' >> /etc/my.cnf.d/docker.cnf && \
    echo 'bind-address=0.0.0.0' >> /etc/my.cnf.d/docker.cnf && \
    echo 'datadir=/var/lib/mysql' >> /etc/my.cnf.d/docker.cnf

RUN sed -i "s|skip-networking|skip-networking=0|g" /etc/my.cnf.d/mariadb-server.cnf

RUN mysql_install_db --user=mysql --datadir=/var/lib/mysql

EXPOSE 3306

COPY requirements/mariadb/conf/create_db.sh .
RUN sh create_db.sh && rm create_db.sh

USER mysql

CMD ["/usr/bin/mysqld", "--skip-log-error"]
