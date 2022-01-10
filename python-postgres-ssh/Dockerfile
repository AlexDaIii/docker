# From: https://github.com/microsoft/vscode-dev-containers

# [Choice] Python version (use -bullseye variants on local arm64/Apple Silicon): 3, 3.10, 3.9, 3.8, 3.7, 3.6, 3-bullseye, 3.10-bullseye, 3.9-bullseye, 3.8-bullseye, 3.7-bullseye, 3.6-bullseye, 3-buster, 3.10-buster, 3.9-buster, 3.8-buster, 3.7-buster, 3.6-buster
ARG VARIANT=3-bullseye
FROM mcr.microsoft.com/vscode/devcontainers/python:${VARIANT}

# [Choice] Node.js version: none, lts/*, 16, 14, 12, 10
# ARG NODE_VERSION="none"
# RUN if [ "${NODE_VERSION}" != "none" ]; then su vscode -c "umask 0002 && . /usr/local/share/nvm/nvm.sh && nvm install ${NODE_VERSION} 2>&1"; fi

# [Optional] If your pip requirements rarely change, uncomment this section to add them to the image.
# COPY requirements.txt /tmp/pip-tmp/
# RUN pip3 --disable-pip-version-check --no-cache-dir install -r /tmp/pip-tmp/requirements.txt \
#    && rm -rf /tmp/pip-tmp

# [Optional] Uncomment this line to install global node packages.
# RUN su vscode -c "source /usr/local/share/nvm/nvm.sh && npm install -g <your-package-here>" 2>&1

# allows us to forward port 22 to whatever we like
EXPOSE 22

ARG USERNAME=vscode

# Uncomment this part out if you need to setup another user
# NOTE: if you do this you will need to change the user in config.sh
# ARG USER_UID=1000
# ARG USER_GID=$USER_UID
# RUN addgroup --gid $GROUP_ID ${USERNAME} \
#     && adduser --disabled-password --gecos '' --uid ${USER_ID} --gid ${GROUP_ID} ${USERNAME}


ARG HOME_DIR=/home/${USERNAME}
ARG VSCODE_REMOTE=${HOME_DIR}/.vscode-server
ARG PYTHON_INSTALL=${HOME_DIR}/.local
ARG JETBRAINS_REMOTE=${HOME_DIR}/.cache/Jetbrains
ENV CONTAINER_USERNAME=${USERNAME}

COPY sshconfig/config.sh /config.sh
COPY sshconfig/run.sh ./run.sh

# setup dirs for VSCode and Jetbrains
RUN mkdir -p ${VSCODE_REMOTE} \
    && chown -R ${USERNAME} ${VSCODE_REMOTE} \
    && mkdir -p ${PYTHON_INSTALL} \
    && chown -R ${USERNAME} ${PYTHON_INSTALL} \ 
    && mkdir -p ${JETBRAINS_REMOTE} \
    && chown -R ${USERNAME} ${JETBRAINS_REMOTE} \
    && chmod +x /*.sh

RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
    && apt-get -y install --no-install-recommends openssh-server sudo

# make a dir for the sshdemon
# delete the pregenerated host keys so they are not stored with the image
RUN mkdir -p /var/run/sshd \
    && /bin/rm -v /etc/ssh/ssh_host_*
# copy the ssh config file 
COPY sshconfig/sshd_config /etc/ssh/sshd_config
COPY sshconfig/sshd_config_original /etc/ssh/sshd_config_original

USER ${USERNAME}

# WORKDIR /home/vscode
# run the run.sh file, keeping the env vars from the current user
CMD ["sudo", "-E", "bash", "/run.sh"]