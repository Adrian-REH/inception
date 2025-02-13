# Usa debian:bookworm-slim como base
FROM debian:bookworm-slim

ENV DEBIAN_FRONTEND=noninteractive

# Instala Nginx y otras dependencias necesarias
RUN apt-get update && apt-get install -y \
    nginx \
    && rm -rf /var/lib/apt/lists/* \
    && ln -sf /dev/stdout /var/log/nginx/access.log \
    && ln -sf /dev/stderr /var/log/nginx/error.log 

# Copia los archivos de configuración personalizados
COPY /requirements/nginx/tools/nginx.conf /etc/nginx/nginx.conf
COPY /requirements/nginx/tools/default.conf /etc/nginx/conf.d/default.conf
COPY /requirements/nginx/tools/certs /etc/nginx/certs

# Expone el puerto 443
EXPOSE 443

# Inicia Nginx en primer plano
CMD ["nginx", "-g", "daemon off;"]
