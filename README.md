# Starter Templates

This contains starter Dockerfiles and Docker Compose files for development.
They are based on the [Microsoft VSCode Remote Dockerfiles](https://github.com/microsoft/vscode-dev-containers/tree/main/containers/).

The ones with ssh allow JetBrains Gateway to ssh into the container.
It is highly reccomended to create a volume for the IDE installed on the container because each remote IDE (without extensions) is about 1.8GB.
Gateway store the remote IDE at `~/.cache/JetBrains`. Inside a containers, `~` will be `/home/vscode`

If you are on a Linux host, you can bind mount the install location to the same location on the host.
In a `docker-compose.yml` for Linux hosts, you would put:

```[yml]
volumes:
    - ~/.cache/JetBrains:/home/vscode/.cache/JetBrains
```

If you are on any other host (MacOS, Windows), you should create an external volume mount because there may be
performance penalties with bind mounts.
