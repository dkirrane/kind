# Install Docker in WSL 2 without Docker Desktop

Follow these instructions
https://nickjanetakis.com/blog/install-docker-in-wsl-2-without-docker-desktop

# docker config

Update Docker config for the following:

- Allow insecure access to forge docker registries you use
- Allow remote access to Docker Daemon in WSL2 from Windows

````bash

sudo bash -c 'cat <<EOT >> /etc/docker/daemon.json
{
    "insecure-registries": [
        "docker.registry.mycompany.com"
    ],
    "hosts": [
        "tcp://0.0.0.0:2375",
        "unix:///var/run/docker.sock"
    ]
}
EOT'

## Restart to pickup config changes
```bash
service docker restart
service docker status
````

## Test connection to Docker Daemon in WSL2 from Powershell

```bash
# From Powershell on Windows
curl http://localhost:2375/info

# From WSL2 shell
docker -H tcp://localhost:2375 ps
```

# docker login

Login to each docker registry you use

```bash
docker login # logs into DockerHub
docker login docker.registry.mycompany.com

# Credentails go to $HOME/.docker/config.json
# kind-create.sh will create a 'regcred' secret from this that can then be used for K8s manifest imagePullSecrets
```
