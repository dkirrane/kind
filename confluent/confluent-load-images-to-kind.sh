#!/bin/bash
set -e
# set -euxo pipefail

SCRIPT_PATH="$(dirname -- "${BASH_SOURCE[0]}")"

# Pull images to local WSL2 Docker
CP_VERSION="7.4.0"
docker pull confluentinc/confluent-init-container:2.6.0
docker pull confluentinc/cp-zookeeper:${CP_VERSION}
docker pull confluentinc/cp-server:${CP_VERSION}
docker pull confluentinc/cp-server-connect:${CP_VERSION}
docker pull confluentinc/cp-enterprise-control-center:${CP_VERSION}
docker pull confluentinc/cp-schema-registry:${CP_VERSION}

# Load images into Kind cluster
kind load docker-image confluentinc/confluent-init-container:2.6.0
kind load docker-image confluentinc/confluent-init-container:2.6.0
kind load docker-image confluentinc/cp-zookeeper:${CP_VERSION}
kind load docker-image confluentinc/cp-server:${CP_VERSION}
kind load docker-image confluentinc/cp-server-connect:${CP_VERSION}
kind load docker-image confluentinc/cp-enterprise-control-center:${CP_VERSION}
kind load docker-image confluentinc/cp-schema-registry:${CP_VERSION}