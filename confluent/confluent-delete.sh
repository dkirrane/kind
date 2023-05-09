#!/bin/bash
set -e
# set -euxo pipefail

SCRIPT_PATH="$(dirname -- "${BASH_SOURCE[0]}")"


kubectl cluster-info --context kind-kind
kubectl get nodes

# Delete Confluent Kafka cluster
kubectl delete -f ${SCRIPT_PATH}/confluent-platform.yaml
helm uninstall confluent-operator -n confluent
