FROM alpine:3.19

RUN apk update && apk add --no-cache tini mariadb mariadb-client

COPY ./conf/mariadb-server.cnf /etc/my.cnf.d/mariadb-server.cnf

COPY ./tools/db_init.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/db_init.sh

# RUN mkdir -p /run/mysqld && chown -R root:root /run/mysqld

EXPOSE 3306

ENTRYPOINT ["/sbin/tini", "--", "/usr/local/bin/db_init.sh"]
