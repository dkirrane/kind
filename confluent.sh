#!/bin/bash
set -e
# set -euxo pipefail

set -a; source .env; set +a
SCRIPT_PATH="$(dirname -- "${BASH_SOURCE[0]}")"


kubectl cluster-info --context kind-kind
kubectl get nodes

# Create Confluent Kafka cluster
# ref: https://docs.confluent.io/operator/current/co-quickstart.html
kubectl create namespace confluent --dry-run=client -o yaml | kubectl apply -f -

helm repo add confluentinc https://packages.confluent.io/helm
helm repo update

helm upgrade --install confluent-operator confluentinc/confluent-for-kubernetes -n confluent

kubectl apply -f ./confluent/confluent-platform.yaml

# View Control Center
kubectl -n confluent port-forward controlcenter-0 9021:9021
sensible-browser http://localhost:9021

# helm delete confluent-operator