# Testing SSHable Containers

Currently, these containers do not work for JetBrains Gateway.

The goal of these was to make a container that allows SSH access so JetBrains Gateway to ssh into the container.
However, currently, it gets stuck trying to connect to the server.

For the volumes needed to store the JetBrains remote IDEs *inside the container* are located at `~/.cache/JetBrains`, `~/.local/share/JetBrains`,
and `~/.config/JetBrains`.
