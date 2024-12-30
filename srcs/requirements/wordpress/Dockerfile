FROM debian:bookworm-slim

RUN apt-get update && apt-get install -y \
    curl \
    php8.2-fpm \
    php8.2-mysql \
    unzip \
    && rm -rf /var/lib/apt/lists/*
RUN   mkdir -p /var/www/html
WORKDIR /var/www/html

RUN  curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x wp-cli.phar \
    && mv wp-cli.phar /usr/local/bin/wp


RUN wp core download --allow-root

COPY /requirements/wordpress/tools/wp-config.php /tmp/wp-config.php
COPY /requirements/wordpress/tools/entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh


ENTRYPOINT ["/bin/bash", "/entrypoint.sh"]

EXPOSE 9000

CMD ["/usr/sbin/php-fpm8.2", "-F"]