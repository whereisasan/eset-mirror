FROM nginx:stable-alpine
RUN apk update && apk upgrade && apk add --no-cache \
git php-fpm php php-curl php-fileinfo php-iconv php-mbstring php-openssl pcre php-simplexml php-sockets php-zlib php-json apache2-utils
RUN touch /etc/nginx/.htpasswd
WORKDIR /eset-mirror
COPY eset-mirror/ .
COPY /configs/default.conf /etc/nginx/conf.d/default.conf
COPY /configs/nod32ms.conf .