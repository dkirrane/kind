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

# Download certs
curl http://avayaitserverca2.avaya.com/pki/ZscalerRootCertificate-2048-SHA256.crt --create-dirs -o ./ca-certs/ZscalerRootCertificate-2048-SHA256.crt
curl http://avayaitserverca2.avaya.com/pki/avayaitserverca2.crt --create-dirs -o ./ca-certs/avayaitserverca2.crt
curl http://avayaitserverca2.avaya.com/pki/avayaitrootca2.crt --create-dirs -o ./ca-certs/avayaitrootca2.crt
curl -k https://confluence.forge.avaya.com/download/attachments/164769524/kaizen.crt --create-dirs -o ./ca-certs/kaizen.crt

certs=("./ca-certs/ZscalerRootCertificate-2048-SHA256.crt" "./ca-certs/avayaitserverca2.crt" "./ca-certs/avayaitrootca2.crt" "./ca-certs/kaizen.crt")

# Load certs into Kind
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
