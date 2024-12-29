FROM debian:bookworm-slim

RUN		apt-get update
RUN		apt-get install -y redis \
		&& rm -rf /var/lib/apt/lists/*

COPY /requirements/bonus/redis/tools/entrypoint.sh /tmp/entrypoint.sh

EXPOSE 6379

CMD ["sh", "/tmp/entrypoint.sh"]