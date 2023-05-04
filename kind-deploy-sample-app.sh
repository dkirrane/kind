#!/bin/bash
set -e
# set -euxo pipefail

kubectl get nodes

echo ""
echo ""
read -r -p "Do you want to deploy a sample Pod to kind? [y/N] " response
case "$response" in
    [yY][eE][sS]|[yY])
        # kubectl delete -f ./sample/
        kubectl apply -f ./sample/
        kubectl get pod simple-pod
        # kubectl describe pod simple-pod
        ;;
    *)
        echo "Skipping sample Pod deployment"
        ;;
esac