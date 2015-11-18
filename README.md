# Elasticsearch Docker image with CZ dictionary

Small docker image based on Alpine Linux image. Installed ICU plugin Czech, Slovak and Polish Dictionaries.

### Installed tools

- Elasticsearch
- ICU plugin
- Hunspell Token Filter (CZ, SK, PL)

### Usage

```
docker run -p 9200:9200 ludekvesely/elasticsearch-cz:latest
```

### Environment variables

- `ES_CLUSTER_NAME` cluster name
- `ES_NODE_LOCAL` true or false
- `ES_NUM_OF_SHARDS` number of shards
- `ES_NUM_OF_REPLICAS` number of replicas
- `ES_PATH_DATA` path to data files
- `ES_PATH_LOG` path to logs
- `ES_PATH_PLUGINS` path to plugins
- `ES_LOG_LEVEL` logger level
- `ES_HEAP_SIZE` heap size (should be half of availible RAM)

