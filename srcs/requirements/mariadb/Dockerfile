FROM mariadb:latest


EXPOSE 3306

RUN apt-get update && apt-get install -y gettext-base

COPY /requirements/mariadb/tools/init.sql /docker-entrypoint-initdb.d/init.sql
COPY /requirements/mariadb/tools/init.sh /usr/local/bin/

RUN chmod +x /usr/local/bin/init.sh

RUN init.sh

