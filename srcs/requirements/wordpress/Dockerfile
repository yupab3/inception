FROM alpine:3.19

RUN apk --no-cache add tini php php-fpm php-mysqli curl tar

RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x wp-cli.phar \
    && mv wp-cli.phar /usr/local/bin/wp

RUN mkdir -p /var/www/html \
    && cd /var/www/html \
    && wp core download --allow-root

COPY .env /var/www/html/.env
COPY setup-wordpress.sh /usr/local/bin/setup-wordpress.sh

RUN chmod +x /usr/local/bin/setup-wordpress.sh \
    && /usr/local/bin/setup-wordpress.sh

COPY php-fpm.conf /etc/php/php-fpm.conf

EXPOSE 9000

ENTRYPOINT ["/sbin/tini", "--"]

CMD ["php-fpm82", "-F"]