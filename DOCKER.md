# Install Docker in WSL 2 without Docker Desktop

Follow these instructions
https://nickjanetakis.com/blog/install-docker-in-wsl-2-without-docker-desktop

# docker login
``bash

sudo bash -c 'cat <<EOT >> /etc/docker/daemon.json
{
    "insecure-registries": [
        "metam-docker-hosted.forge.avaya.com"
    ]
}
EOT'

service docker restart
service docker status

docker login
docker login metam-docker-hosted.forge.avaya.com

```
