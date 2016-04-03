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
	echo "${ES_ADDITIONAL_CONFIG}" | awk '{gsub(/\\n/,"\n")}1' | while read -r line; do
		echo "$line" >> /elasticsearch/config/elasticsearch.yml
	done
	echo -e "\nElasticsearch configuration:\n"
	cat /elasticsearch/config/elasticsearch.yml
	mkdir -p $ES_PATH_DATA
	mkdir -p $ES_PATH_LOG
	chmod 777 $ES_PATH_LOG
	grep '^elasticsearch:' /etc/passwd >/dev/null 2>/dev/null || ( adduser -S elasticsearch && addgroup elasticsearch )
	chown -R elasticsearch:elasticsearch $ES_PATH_DATA
	chown -R elasticsearch:elasticsearch /elasticsearch
	sleep 1
	exec gosu elasticsearch /elasticsearch/bin/elasticsearch -Des.logger.level=$ES_LOG_LEVEL
else
	exec "$@"
fi

