# Usa debian:bookworm-slim como base
FROM debian:bookworm-slim

# Establece las variables de entorno necesarias
ENV DEBIAN_FRONTEND=noninteractive \
    WORDPRESS_VERSION=6.3.2 \
    PHP_UPLOAD_MAX_FILESIZE=64M \
    PHP_POST_MAX_SIZE=64M \
    PHP_MEMORY_LIMIT=256M \
    PHP_MAX_EXECUTION_TIME=300

# Instala las dependencias necesarias
RUN apt-get update && apt-get install -y \
    apache2 \
    php8.2-fpm \
    php8.2-mysql \
    curl \
    wget \
    tar \
    unzip \
    mariadb-client \
    && rm -rf /var/lib/apt/lists/*

# Descarga WordPress
RUN wget -O wordpress.tar.gz https://wordpress.org/wordpress-${WORDPRESS_VERSION}.tar.gz \
    && tar -xzf wordpress.tar.gz -C /var/www/html --strip-components=1 \
    && rm wordpress.tar.gz \
    && chown -R www-data:www-data /var/www/html \
    && apt-get purge -y --auto-remove wget

# Configura Apache
RUN a2enmod rewrite \
    && echo '<Directory /var/www/html/>\n\
        Options +FollowSymLinks\n\
        AllowOverride All\n\
        Require all granted\n\
    </Directory>' > /etc/apache2/conf-available/wordpress.conf \
    && a2enconf wordpress

RUN a2enmod proxy proxy_fcgi

COPY /requirements/wordpress/tools/000-default.conf /etc/apache2/sites-available/000-default.conf
RUN a2ensite 000-default.conf

# Expone el puerto 80
EXPOSE 80

COPY /requirements/wordpress/tools/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]

# Define el punto de entrada

