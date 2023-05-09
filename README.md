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

## Useful scripts
```bash
git clone https://bitbucket.forge.avaya.com/scm/metam/kind.git
cd kind
```

## Create local Kubernetes cluster
```bash
./kind-create.sh
```
![](./docs/images/kind.png)

## Connect to Kubernetes cluster
```bash
# By default kind creates/updates $HOME/.kube/config
kubectl cluster-info --context kind-kind

# Optionally you can output to seperate file $HOME/.kube/kind/config
./kind-kubeconfig.sh
export KUBECONFIG="$HOME/.kube/kind/config"
kubectl get nodes
```

## Deploy an Ingress (Optional)
```bash
./kind-ingress.sh
```

## Deploy an Application (Optional)
```bash
# Helm

```

## Destroy Kubernetes cluster
```bash
./kind-delete.sh
```

# WSL2 Docker cleanup
From time to time you may want to cleanup Docker containers, unused images, volumes and networks.
```bash
docker system prune --all
```

# References:
- https://kind.sigs.k8s.io/docs/user/quick-start/
- https://kind.sigs.k8s.io/docs/user/using-wsl2/
