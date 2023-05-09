#!/bin/bash
set -e
# set -euxo pipefail

SCRIPT_PATH="$(dirname -- "${BASH_SOURCE[0]}")"

kubectl cluster-info --context kind-kind
kubectl get nodes

# Load Confluent Images (avoid kind having to pull images)
${SCRIPT_PATH}/confluent-load-images-to-kind.sh

# Create Confluent Kafka cluster
# ref: https://docs.confluent.io/operator/current/co-quickstart.html
kubectl create namespace confluent --dry-run=client -o yaml | kubectl apply -f -

helm repo add confluentinc https://packages.confluent.io/helm
helm repo update confluentinc

helm upgrade --install confluent-operator confluentinc/confluent-for-kubernetes -n confluent

kubectl apply -f ${SCRIPT_PATH}/confluent-platform.yaml
