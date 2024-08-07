#!/bin/sh
set -e

# 초기화
# if [ -d "/var/lib/mysql/mysql" ]; then
#     echo 'MariaDB 데이터 디렉토리가 이미 초기화되었습니다.'
# else
    echo 'MariaDB 데이터 디렉토리 초기화...'
    mysql_install_db --user=mysql --datadir=/var/lib/mysql --skip-test-db
    echo '초기화 완료.'

    mysqld --user=mysql --datadir=/var/lib/mysql --bootstrap << EOSQL
        FLUSH PRIVILEGES;
        DELETE FROM mysql.user WHERE user='';
        CREATE USER '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';
        CREATE DATABASE ${WORDPRESS_DB_NAME};
        GRANT ALL PRIVILEGES ON ${WORDPRESS_DB_NAME}.* TO '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';
        FLUSH PRIVILEGES;
EOSQL
    echo '초기 설정 완료.'
# fi

exec "$@"
