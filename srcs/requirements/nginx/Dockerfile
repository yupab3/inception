FROM alpine:3.19

RUN apk --no-cache add tini nginx openssl && \
	mkdir -p /etc/nginx/ssl && \
	openssl req -new -newkey rsa:2048 -days 365 -nodes -x509 \
    -subj "/C=KR/ST=42Seoul/L=2cluster/O=dongyeuk/CN=dongyeuk.42.fr" \
    -keyout /etc/nginx/ssl/nginx.key -out /etc/nginx/ssl/nginx.crt

COPY ./conf/nginx.conf /etc/nginx/nginx.conf

RUN mkdir -p /var/www/html && \
	chown -R nginx:nginx /var/www/html

COPY ./tools/index.html /var/www/html/index.html

EXPOSE 443

ENTRYPOINT ["/sbin/tini", "--"]

CMD ["nginx", "-g", "daemon off;"]