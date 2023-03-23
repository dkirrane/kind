#!/bin/bash
set -e
# set -euxo pipefail

set -a; source .env; set +a
SCRIPT_PATH="$(dirname -- "${BASH_SOURCE[0]}")"

# Get kubeconfig
mkdir -p $HOME/.kube/kind/
kind export kubeconfig --kubeconfig $HOME/.kube/kind/config

echo "You can now use your cluster with:"
echo ""
echo 'export KUBECONFIG="$HOME/.kube/kind/config"'
echo "kubectl cluster-info"
echo "kubectl get nodes"
