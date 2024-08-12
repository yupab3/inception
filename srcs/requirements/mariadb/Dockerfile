FROM alpine:3.19

RUN apk update && apk add --no-cache tini mariadb mariadb-client

COPY ./tools/db_init.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/db_init.sh

COPY ./conf/my.cnf /etc/my.cnf

RUN mkdir -p /run/mysqld && chown -R root:root /run/mysqld

EXPOSE 3306

ENTRYPOINT ["/sbin/tini", "--", "/usr/local/bin/db_init.sh"]
