#!/bin/bash
set -e
# set -euxo pipefail

SCRIPT_PATH="$(dirname -- "${BASH_SOURCE[0]}")"

# View Control Center
kubectl -n confluent port-forward controlcenter-0 9021:9021
sensible-browser http://localhost:9021
