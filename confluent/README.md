# Overview
Deploys Confluent Platform (ZooKeeper, Kafka, Kafka Connect, SchemaRegistry, ControlCenter)
Each component can be optionally toggled off.
By default it deploys 1 ZooKeeper, 1 Kafka, 1 SchemaRegistry, 1 ControlCenter

ref: https://docs.confluent.io/operator/current/co-quickstart.html

# Steps
```bash

# Create Kafka Cluster
confluent-create.sh

# View Control Center
confluent-create.sh

# Delete Kafka Cluster
confluent-delete.sh

```