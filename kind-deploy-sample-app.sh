#!/bin/bash
set -e
# set -euxo pipefail

kubectl get nodes

read -p "Proceed to deploy application? " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]
then
    [[ "$0" = "$BASH_SOURCE" ]] && exit 1 || return 1 # handle exits from shell or function but don't exit interactive shell
fi

kubectl apply -f ./sample/