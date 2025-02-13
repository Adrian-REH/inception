FROM debian:bookworm-slim

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get upgrade -y && apt-get install -y \
    vsftpd \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /etc/vsftpd && \
    mkdir -p /var/run/vsftpd/empty && \
    chmod 755 /var/run/vsftpd/empty && \
    chown root:root /var/run/vsftpd/empty


COPY /requirements/bonus/ftp-service/tools/vsftpd.conf /tmp/vsftpd.conf
COPY /requirements/bonus/ftp-service/tools/entrypoint.sh /tmp/entrypoint.sh

RUN chmod +x /tmp/entrypoint.sh

EXPOSE 2121

ENTRYPOINT ["sh", "/tmp/entrypoint.sh"]
