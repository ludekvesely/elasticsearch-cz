# Elasticsearch Docker image with CZ dictionary

Small docker image based on Alpine Linux image. Installed ICU plugin, Czech, Slovak and Polish Dictionaries.

### Installed tools

- Elasticsearch
- ICU plugin
- Hunspell Token Filter (CZ, SK, PL)
- Delete by query plugin

### Usage

```
docker run -p 9200:9200 ludekvesely/elasticsearch-cz:latest
```

### Environment variables

- `ES_CLUSTER_NAME` cluster name
- `ES_NODE_LOCAL` true or false
- `ES_NUM_OF_SHARDS` number of shards (default 1)
- `ES_NUM_OF_REPLICAS` number of replicas (default 0)
- `ES_PATH_DATA` path to data files
- `ES_PATH_LOG` path to logs
- `ES_LOG_LEVEL` logger level
- `ES_HEAP_SIZE` heap size (should be half of availible RAM)
- `ES_ADDITIONAL_CONFIG` additional configuration

### Exposed ports

- 9200
- 9300

