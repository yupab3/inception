#!/bin/sh
set -e

mkdir -p /run/mysqld
touch /run/mysqld/mysqld.sock

#초기화
if [ -d "/var/lib/mysql/mysql" ]; then
    echo 'MariaDB 가 이미 초기화 되어있습니다.'
else
    echo 'MariaDB 데이터 디렉토리 초기화...'
    mysql_install_db --user=mysql --datadir=/var/lib/mysql
    echo '초기화 완료.'

    mariadbd --user=root --bootstrap << EOSQL
        FLUSH PRIVILEGES;
        DELETE FROM mysql.user WHERE user='';
        CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';
        CREATE DATABASE IF NOT EXISTS ${WORDPRESS_DB_NAME};
        GRANT ALL PRIVILEGES ON ${WORDPRESS_DB_NAME}.* TO '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';
EOSQL
    echo '초기 설정 완료.'

if [ -z $(getent passwd mariadb) ]; then
    adduser --disabled-password mariadb
    chown -R mariadb:mariadb /var/lib/mysql
    chmod -R 755 /var/lib/mysql
fi

fi

exec mariadbd -u root