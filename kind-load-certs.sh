#!/usr/bin/env bash

set -e -o pipefail; [[ -n "$DEBUG" ]] && set -x

CERT_DIR="${CERT_DIR:-"/usr/local/share/ca-certificates"}"

function usage() {
  echo "Usage: $(basename "$0") [-n name]" >&2
}

while getopts n: OPT; do
  case $OPT in
    n) name="$OPTARG"
       ;;
    *) usage
       exit 1
       ;;
  esac
done
shift "$((OPTIND - 1))"

name="${name:-"kind"}"

containers="$(kind get nodes --name="$name" 2>/dev/null)"
if [[ "$containers" == "" ]]; then
  echo "No kind nodes found for cluster \"$name\"" >&2
  exit 1
fi

# (Optional) Download any CA certs you require e.g.
# curl -k http://mycompany/Zscaler.crt --create-dirs -o ./ca-certs/Zscaler.crt
# Verify the certs are in PEM format
# openssl verify ./ca-certs/Zscaler.crt
# If necessary convert from DER to PEM
# openssl x509 -inform der -in ./ca-certs/Zscaler.crt -out ./ca-certs/Zscaler.pem

# certs=("./ca-certs/Zscaler.pem")

# If necessary load certs local Truststore e.g. WSL2 Ubuntu Truststore
# echo "Load certs into WSL2 Ubuntu Truststore..."
# sudo cp ./ca-certs/*.crt /usr/local/share/ca-certificates/
# sudo update-ca-certificates

# Load certs into Kind cluster nodes
while IFS= read -r container; do
  for certfile in "${certs[@]}"; do
    echo "Copying ${certfile} to ${container}:${CERT_DIR}"
    docker cp "$certfile" "${container}:${CERT_DIR}"
  done

  echo "Updating CA certificates in ${container}..."
  docker exec "$container" update-ca-certificates

  echo "Restarting containerd"
  docker exec "$container" systemctl restart containerd
done <<< "$containers"
