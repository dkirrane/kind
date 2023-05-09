#!/bin/bash
set -e
# set -euxo pipefail

SCRIPT_PATH="$(dirname -- "${BASH_SOURCE[0]}")"

kubectl cluster-info --context kind-kind
kubectl get nodes

# Load Confluent Images (avoid kind having to pull images)
echo ""
read -r -p "Do you want to Load Confluent Images into the Kind cluster? [y/N] " response
case "$response" in
    [yY][eE][sS]|[yY])
        ${SCRIPT_PATH}/confluent-load-images-to-kind.sh
        ;;
    *)
        echo "Skipping loading of Confluent Images into the Kind"
        ;;
esac

# Create Confluent Kafka cluster
# ref: https://docs.confluent.io/operator/current/co-quickstart.html
kubectl create namespace confluent --dry-run=client -o yaml | kubectl apply -f -

helm repo add confluentinc https://packages.confluent.io/helm
helm repo update confluentinc

helm upgrade --install confluent-operator confluentinc/confluent-for-kubernetes -n confluent

kubectl apply -f ${SCRIPT_PATH}/confluent-platform.yaml
