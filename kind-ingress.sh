#!/bin/bash
set -e
# set -euxo pipefail

set -a; source .env; set +a
SCRIPT_PATH="$(dirname -- "${BASH_SOURCE[0]}")"

# Helm
helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
helm repo update
helm upgrade --install ingress-nginx ingress-nginx/ingress-nginx \
   --version 4.6.0 \
   --set controller.service.type=NodePort \
   --set controller.service.nodePorts.http=30080 \
   --set controller.service.nodePorts.https=30443
helm status ingress-nginx

# Access Service
# Use hostPort of kind node, to work the containerPort and the Kubernetes service nodePort need to be equal.
curl localhost:80
curl localhost:443