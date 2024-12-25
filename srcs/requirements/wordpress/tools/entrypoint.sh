#!/bin/bash

# Inicia PHP-FPM en segundo plano
php-fpm8.2 &

# Inicia Apache en primer plano
apachectl -D FOREGROUND
