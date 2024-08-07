FROM alpine:3.19

RUN apk --no-cache add tini php php-fpm php-mysqli php-phar curl tar php-mbstring

RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x wp-cli.phar \
    && mv wp-cli.phar /usr/local/bin/wp

COPY ./tools/setup-wordpress.sh /usr/local/bin/setup-wordpress.sh

RUN chmod +x /usr/local/bin/setup-wordpress.sh

COPY ./conf/php-fpm.conf /etc/php82/php-fpm.d/www.conf

EXPOSE 9000

ENTRYPOINT ["/sbin/tini", "--", "/usr/local/bin/setup-wordpress.sh"]
