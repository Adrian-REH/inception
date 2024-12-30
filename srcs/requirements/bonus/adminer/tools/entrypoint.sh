#! /bin/bash


curl -L -o index.php https://github.com/vrana/adminer/releases/download/v4.8.1/adminer-4.8.1.php

sed -i 's/listen = \/run\/php\/php7.3-fpm.sock/listen = 9090/g' /etc/php/7.3/fpm/pool.d/www.conf

mkdir /run/php
# Inicia PHP-FPM
echo "Iniciando PHP-FPM..."
/usr/sbin/php-fpm7.3 -F
