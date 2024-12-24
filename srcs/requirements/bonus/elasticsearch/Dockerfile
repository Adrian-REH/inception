FROM docker.elastic.co/elasticsearch/elasticsearch:8.10.2

ENV discovery.type=single-node
ENV xpack.security.enabled=false

USER root

RUN mkdir -p /usr/share/elasticsearch/data && chown -R elasticsearch:elasticsearch /usr/share/elasticsearch/data

USER elasticsearch

EXPOSE 9200 9300

CMD ["/bin/elasticsearch"]
