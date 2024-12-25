FROM debian:bookworm-slim

ENV KIBANA_VERSION=8.10.2
ENV KIBANA_HOME=/usr/share/kibana

RUN set -ex && \
    apt-get update && \
    apt-get install -y --no-install-recommends \
        ca-certificates \
        curl \
    && rm -rf /var/lib/apt/lists/* \
    && curl -fsSL -o kibana.tar.gz https://artifacts.elastic.co/downloads/kibana/kibana-${KIBANA_VERSION}-linux-x86_64.tar.gz \
    && mkdir -p ${KIBANA_HOME} \
	&& groupadd -r kibana \
    && useradd -r -g kibana -d ${KIBANA_HOME} -s /sbin/nologin kibana \
	&& tar --owner=kibana --group=kibana -xzf kibana.tar.gz --strip-components=1 -C ${KIBANA_HOME} \
    && rm kibana.tar.gz 

COPY /requirements/bonus/kibana/tools/kibana.yml /usr/share/kibana/config/kibana.yml
#COPY /requirements/bonus/kibana/tools/kibana.yml /kibana/config/kibana.yml
RUN apt-get purge -y --auto-remove curl

USER kibana
WORKDIR ${KIBANA_HOME}

EXPOSE 5601

CMD ["bin/kibana"]
