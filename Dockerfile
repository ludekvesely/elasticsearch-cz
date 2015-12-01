FROM develar/java:latest
MAINTAINER Ludek Vesely <ludek.vesely@email.com>

ENV ES_VERSION 2.1.0

RUN apk add --update curl && \
  ( curl -Lskj https://download.elasticsearch.org/elasticsearch/elasticsearch/elasticsearch-$ES_VERSION.tar.gz | \
  gunzip -c - | tar xf - ) && \
  mv /elasticsearch-$ES_VERSION /elasticsearch && \
  curl -o /usr/local/bin/gosu -sSL "https://github.com/tianon/gosu/releases/download/1.2/gosu-amd64" && chmod +x /usr/local/bin/gosu && \
  rm -rf $(find /elasticsearch | egrep "(\.(exe|bat)$|sigar/.*(dll|winnt|x86-linux|solaris|ia64|freebsd|macosx))") && \
  apk del curl && \
  rm -rfv /var/cache/apk/* /tmp/* /var/tmp/*

RUN cd /elasticsearch && bin/plugin install analysis-icu
ADD hunspell /elasticsearch/config/hunspell
ADD entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ADD elasticsearch.yml /elasticsearch/config/elasticsearch.yml

ENV ES_CLUSTER_NAME elastic
ENV ES_NODE_LOCAL true
ENV ES_NUM_OF_SHARDS 1
ENV ES_NUM_OF_REPLICAS 0
ENV ES_PATH_DATA /var/services/data/elasticsearch
ENV ES_PATH_LOG /var/services/log/elasticsearch
ENV ES_LOG_LEVEL INFO
ENV ES_HEAP_SIZE 1G
ENV ES_MAX_RESULT_WINDOW 2147483647

ENTRYPOINT ["/entrypoint.sh"]
CMD ["elasticsearch"]
EXPOSE 9200 9300

