# Kind
kind is a tool for running local Kubernetes clusters using Docker container “nodes”.
https://kind.sigs.k8s.io/

## Prerequisties
- [WSL2](https://kind.sigs.k8s.io/docs/user/using-wsl2/#setting-up-wsl2)
- [Docker](./docs/DOCKER.md)

## Kind Install
```bash
# Install on Linux (WSL2 Ubuntu)
curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.17.0/kind-linux-amd64
chmod +x ./kind
sudo mv ./kind /usr/local/bin/kind
```

## Clone scripts
```bash
git clone https://bitbucket.forge.avaya.com/scm/metam/kind.git
cd kind
```

## Create local Kubernetes cluster
```bash
./kind-create.sh
```
- [Install Docker](./docs/images/kind.png)

## Connect to Kubernetes cluster
```bash
# Creates $HOME/.kube/config
kubectl cluster-info --context kind-kind

# (Optional) Export kubeconfig
./kind-kubeconfig.sh
```

## Destroy Kubernetes cluster
```bash
./kind-delete.sh
```

# References:
- https://kind.sigs.k8s.io/docs/user/quick-start/
- https://kind.sigs.k8s.io/docs/user/using-wsl2/
