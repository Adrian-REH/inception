#!/bin/bash

set -e



if [ ! -f /var/www/html/wp-config.php ]; then
	wp core download --allow-root
fi


cp /tmp/wp-config.php /var/www/html/wp-config.php
echo "Config WordPress..."

wp core install \
	--url="$DOMAIN_NAME" \
	--title="$WP_TITLE" \
	--admin_user="$WP_ADMIN_USER" \
	--admin_password="$WP_ADMIN_PASSWORD" \
	--admin_email="$WP_ADMIN_EMAIL" \
	--skip-email \
	--allow-root

echo "WordPress instalado correctamente."

USER_EXISTS=$(wp user get "$WP_USER" --field=user_login --allow-root 2>/dev/null || echo "no")
EMAIL_EXISTS=$(wp user list --field=user_email --allow-root | grep -Fx "$WP_EMAIL" || echo "no")

if [ "$USER_EXISTS" = "no" ] && [ "$EMAIL_EXISTS" = "no" ]; then
	echo "Creando usuario '$WP_USER' con correo '$WP_EMAIL'..."
	wp user create "$WP_USER" "$WP_EMAIL" \
		--role=author \
		--user_pass="$WP_PASSWORD" \
		--allow-root
	echo "Usuario '$WP_USER' creado correctamente."
else
	if [ "$USER_EXISTS" != "no" ]; then
		echo "El usuario '$WP_USER' ya existe, omitiendo la creación."
	fi
	if [ "$EMAIL_EXISTS" != "no" ]; then
		echo "El correo electrónico '$WP_EMAIL' ya está en uso, omitiendo la creación."
	fi
fi

chown -R www-data:www-data /var/www/html
# Instala y activa el tema
wp theme install astra --activate --allow-root

# Instala y activa plugins
wp config set WP_REDIS_HOST redis --allow-root
wp config set WP_REDIS_PORT 6379 --allow-root
wp config set WP_CACHE_KEY_SALT $DOMAIN_NAME --allow-root
wp config set WP_REDIS_CLIENT phpredis --allow-root
wp plugin install redis-cache --activate --allow-root
wp plugin update --all --allow-root

# Habilita Redis Cache
wp redis enable --allow-root

sed -i 's/listen = \/run\/php\/php8.2-fpm.sock/listen = 9000/g' /etc/php/8.2/fpm/pool.d/www.conf
sed -i 's/;clear_env = no/clear_env = no/' /etc/php/8.2/fpm/pool.d/www.conf
mkdir -p /run/php
# Inicia PHP-FPM
echo "Iniciando PHP-FPM..."



exec "$@"