#!/bin/bash
set -e
# set -euxo pipefail

set -a; source .env; set +a
SCRIPT_PATH="$(dirname -- "${BASH_SOURCE[0]}")"

# Create Kind cluster
kind create cluster --config=kind-config.yaml
kubectl cluster-info --context kind-kind
kubectl get nodes

${SCRIPT_PATH}/kind-kubeconfig.sh

# Fix ImagePullBackOff - https://github.com/kubernetes-sigs/kind/issues/1010
# NO longer needed see containerdConfigPatches
# ${SCRIPT_PATH}/kind-load-certs.sh

# Add regcred secret for Image Pull
${SCRIPT_PATH}/kind-load-image-pull-secret.sh

# Deploy sample Pod
${SCRIPT_PATH}/kind-deploy-sample-app.sh
