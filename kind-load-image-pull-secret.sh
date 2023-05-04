#!/usr/bin/env bash

set -e -o pipefail

DOCKER_CONFIG_JSON=$HOME/.docker/config.json
if [ ! -f "$DOCKER_CONFIG_JSON" ]; then
    echo "$DOCKER_CONFIG_JSON does not exist. Have you run 'docker login' commands. Please see ./docs/DOCKER.md"
fi

kubectl create secret generic regcred \
    --from-file=.dockerconfigjson=$DOCKER_CONFIG_JSON \
    --type=kubernetes.io/dockerconfigjson