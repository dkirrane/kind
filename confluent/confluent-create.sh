#!/bin/bash
set -e
# set -euxo pipefail

SCRIPT_PATH="$(dirname -- "${BASH_SOURCE[0]}")"

kubectl cluster-info --context kind-kind
kubectl get nodes

# Load Confluent Images (avoid kind having to pull images)
echo ""
read -r -p "Do you want to Load Confluent Images into the Kind cluster (avoids image pull)? [y/N] " response
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
# kubectl create namespace confluent --dry-run=client -o yaml | kubectl apply -f -

# helm repo add confluentinc https://packages.confluent.io/helm
# helm repo update confluentinc

# helm upgrade --install confluent-operator confluentinc/confluent-for-kubernetes -n confluent

echo ""
echo "Select Kafka deployment type"
deployment_types=( "Single_Node" "3_Nodes" "Quit" )
select opt in "${deployment_types[@]}"
do
    case $opt in
        "Single_Node")
            echo "Deploying a single node Kafka cluster"
            kubectl apply -f ${SCRIPT_PATH}/confluent-platform-singlenode.yaml
            break;;
        "3_Nodes")
            echo "Deploying a 3 node Kafka cluster"
            kubectl apply -f ${SCRIPT_PATH}/confluent-platform.yaml
            break;;
        "Quit")
           echo "We're done"
           exit;;
        *)
           echo "Ooops";;
    esac
done

# Create Secrets
# Kafka security.protocol=PLAINTEXT
echo ""
echo "Creating Kafka secrets"
kubectl create secret generic kafka-config \
    --from-literal=kafka.bootstrapServer=kafka.confluent.svc.cluster.local:9071 \
    --save-config \
    --dry-run=client \
    -o yaml | \
    kubectl apply -f -

kubectl create secret generic schema-registry-config \
    --from-literal=kafka.schemaRegistryUrl=http://schemaregistry.confluent.svc.cluster.local:8081 \
    --save-config \
    --dry-run=client \
    -o yaml | \
    kubectl apply -f -

kubectl create secret generic kafka-connect-config \
    --from-literal=kafka.kafkaConnectUrl=http://connect.confluent.svc.cluster.local:8083 \
    --save-config \
    --dry-run=client \
    -o yaml | \
    kubectl apply -f -