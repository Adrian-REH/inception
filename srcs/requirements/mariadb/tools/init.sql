-- Crear base de datos si no existe
CREATE DATABASE IF NOT EXISTS ${WP_DB};

CREATE USER IF NOT EXISTS '${WP_USER}' IDENTIFIED BY '${WP_PASSWORD}';

-- Crear el usuario ADMIN (si no existe) y darle una contraseña
CREATE USER IF NOT EXISTS '${WP_ADMIN_USER}' IDENTIFIED BY '${WP_ADMIN_PASSWORD}';

-- Otorgar privilegios completos al usuario ADMIN sobre todas las bases de datos
GRANT ALL PRIVILEGES ON *.* TO '${WP_ADMIN_USER}'@'%' WITH GRANT OPTION;

-- Aplicar cambios
FLUSH PRIVILEGES;
