#!/bin/bash
set -e
# set -euxo pipefail

set -a; source .env; set +a
SCRIPT_PATH="$(dirname -- "${BASH_SOURCE[0]}")"

# Create Kind cluster
kind create cluster --config=kind-config.yaml
kubectl cluster-info --context kind-kind
kubectl get nodes

# Fix ImagePullBackOff - https://github.com/kubernetes-sigs/kind/issues/1010
${SCRIPT_PATH}/kind-load-certs.sh
