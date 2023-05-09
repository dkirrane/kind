#!/bin/bash
set -e
# set -euxo pipefail

SCRIPT_PATH="$(dirname -- "${BASH_SOURCE[0]}")"

# Create Topics
kubectl apply -f ./confluent-kafka-topics.yaml