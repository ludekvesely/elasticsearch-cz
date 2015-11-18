#!/bin/sh
set -e

if [ "$1" = 'elasticsearch' ]; then
  sed -i \
    -e "s#-ES_CLUSTER_NAME-#${ES_CLUSTER_NAME}#" \
    -e "s#-ES_NODE_LOCAL-#${ES_NODE_LOCAL}#" \
    -e "s#-ES_NUM_OF_SHARDS-#${ES_NUM_OF_SHARDS}#" \
    -e "s#-ES_NUM_OF_REPLICAS-#${ES_NUM_OF_REPLICAS}#" \
    -e "s#-ES_PATH_DATA-#${ES_PATH_DATA}#" \
    -e "s#-ES_PATH_LOG-#${ES_PATH_LOG}#" \
    /elasticsearch/config/elasticsearch.yml
  mkdir -p $ES_PATH_DATA
  mkdir -p $ES_PATH_LOG
  chmod 777 $ES_PATH_LOG
  adduser -S elasticsearch
  addgroup elasticsearch
  chown -R elasticsearch:elasticsearch $ES_PATH_DATA
  chown -R elasticsearch:elasticsearch /elasticsearch
  exec gosu elasticsearch /elasticsearch/bin/elasticsearch -Des.logger.level=$ES_LOG_LEVEL
fi
exec "$@"

