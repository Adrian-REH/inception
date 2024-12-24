#!/bin/bash


# Expandir variables de entorno en el archivo .sql
envsubst < ./docker-entrypoint-initdb.d/init.sql > ./docker-entrypoint-initdb.d/init.sql


echo "Initializing MariaDB..."