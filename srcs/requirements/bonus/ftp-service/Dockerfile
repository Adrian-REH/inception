FROM debian:bookworm-slim

# Establecer el entorno para evitar preguntas interactivas durante la instalación
ENV DEBIAN_FRONTEND=noninteractive

# Instalar vsftpd
RUN apt-get update && apt-get upgrade -y && apt-get install -y \
    vsftpd \
    && rm -rf /var/lib/apt/lists/*

# Crear el directorio necesario para la configuración de vsftpd
RUN mkdir -p /etc/vsftpd && \
    mkdir -p /var/run/vsftpd/empty && \
    chmod 755 /var/run/vsftpd/empty && \
    chown root:root /var/run/vsftpd/empty


# Copiar el archivo de configuración y el script de entrada al contenedor
COPY /requirements/bonus/ftp-service/tools/vsftpd.conf /tmp/vsftpd.conf
COPY /requirements/bonus/ftp-service/tools/entrypoint.sh /tmp/entrypoint.sh

# Asegurarse de que el script de entrada sea ejecutable
RUN chmod +x /tmp/entrypoint.sh


EXPOSE 2121
# Iniciar vsftpd con el archivo de configuración copiado
ENTRYPOINT ["sh", "/tmp/entrypoint.sh"]
