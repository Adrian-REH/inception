FROM debian:bookworm-slim

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    vsftpd \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /var/run/vsftpd/empty

COPY vsftpd.conf /etc/vsftpd.conf

EXPOSE 20 21 21100-21110

CMD ["vsftpd", "/etc/vsftpd.conf"]
