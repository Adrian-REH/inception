FROM debian:bookworm-slim

ENV DEBIAN_FRONTEND=noninteractive \
    WORDPRESS_VERSION=6.3.2 \
    PHP_UPLOAD_MAX_FILESIZE=64M \
    PHP_POST_MAX_SIZE=64M \
    PHP_MEMORY_LIMIT=256M \
    PHP_MAX_EXECUTION_TIME=300

RUN apt-get update && apt-get install -y \
    apache2 \
    php \
    php-mysql \
    adminer \
    && rm -rf /var/lib/apt/lists/* \
	&& ln -sf /dev/stdout /var/log/apache2/access.log \
    && ln -sf /dev/stderr /var/log/apache2/error.log

RUN a2enconf adminer
RUN echo "Alias /adminer /usr/share/adminer/adminer" > /etc/apache2/conf-available/adminer.conf

EXPOSE 80

# Define el punto de entrada
CMD ["apachectl", "-D", "FOREGROUND"]