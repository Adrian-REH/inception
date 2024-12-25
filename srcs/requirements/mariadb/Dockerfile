# Usar una imagen base de Debian
FROM debian:latest

# Establecer variables de entorno
ENV DEBIAN_FRONTEND=noninteractive

# Instalar MariaDB y dependencias necesarias
RUN apt-get update && apt-get install -y \
    mariadb-server \
    && rm -rf /var/lib/apt/lists/*


RUN apt-get update && apt-get install -y gettext-base

COPY /requirements/mariadb/tools/init.sql /init.sql
COPY /requirements/mariadb/tools/init.sh /usr/local/bin/
COPY /requirements/mariadb/tools/50-server.cnf /etc/mysql/mariadb.conf.d/

RUN chmod +x /usr/local/bin/init.sh


# Exponer los puertos de MariaDB y métricas
EXPOSE 3306

# Crear un health check básico
HEALTHCHECK CMD pgrep -x mysqld > /dev/null || exit 1

# Configurar MariaDB para métricas
RUN echo "[mysqld]\n\
performance_schema = ON" >> /etc/mysql/my.cnf

ENV MYSQL_DATA_DIR=/var/lib/mysql

ENTRYPOINT [ "/usr/local/bin/init.sh"]


CMD ["mysqld"]
