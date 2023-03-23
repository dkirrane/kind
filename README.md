# kind
kind is a tool for running local Kubernetes clusters using Docker container “nodes”.
https://kind.sigs.k8s.io/

## Install
https://kind.sigs.k8s.io/docs/user/quick-start/#installation

```bash
# Install on Linux (WSL2 Ubuntu)

curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.17.0/kind-linux-amd64
chmod +x ./kind
sudo mv ./kind /usr/local/bin/kind
```

## Create cluster

```bash
./kind-create.sh
```

## Connect to cluster
```bash
# $HOME/.kube/config
kubectl cluster-info --context kind-kind

# (Optional) Export kubeconfig
./kind-kubeconfig.sh
```

## Destroy cluster

```bash
./kind-delete.sh
```

# References:

- https://kind.sigs.k8s.io/docs/user/quick-start/
- https://kind.sigs.k8s.io/docs/user/using-wsl2/
