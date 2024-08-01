# See here for image contents:
# https://github.com/microsoft/vscode-dev-containers/tree/v0.148.1/containers/python-3/.devcontainer/base.Dockerfile
ARG VARIANT="3.11"
FROM mcr.microsoft.com/vscode/devcontainers/python:0-${VARIANT}
ARG INSTALL_NODE="true"
ARG NODE_VERSION="lts/*"
RUN if [ "${INSTALL_NODE}" = "true" ]; then su vscode -c "source /usr/local/share/nvm/nvm.sh && nvm install ${NODE_VERSION} 2>&1"; fi

RUN pip3 --disable-pip-version-check --no-cache-dir install -U \
  'poetry==1.1.13' \
  'pip==22.1.2'

USER vscode
COPY pyproject.toml /opt/base/pyproject.toml
COPY poetry.toml /opt/base/poetry.toml
RUN sudo chown -R vscode:vscode /opt

ENV PIP_TARGET=/opt/pip
ENV PYTHONPATH=/opt/pip
ENV PATH="${PIP_TARGET}/bin:${PATH}"
WORKDIR /opt/base
RUN poetry add --no-interaction \
  'ipykernel' \
  'jupyter' \
  'nbstripout' \
  'pre-commit' \
  'black' \
  && rm -rf ~/.cache/pypoetry/{cache,artifacts}

# prevent homebrew from updating or upgrading to save time
ENV HOMEBREW_NO_AUTO_UPDATE=1
ENV HOMEBREW_NO_INSTALL_UPGRADE=1

WORKDIR /tmp
RUN curl \
  -Lk \
  'https://code.visualstudio.com/sha/download?build=stable&os=cli-alpine-x64' \
  --output vscode_cli.tar.gz
RUN sudo rm /usr/local/bin/code
RUN sudo tar -xf vscode_cli.tar.gz -C /usr/local/bin

ENV TUNNEL_NAME=runpod
ENV VSCODE_CLI_USE_FILE_KEYCHAIN=true

WORKDIR /home/vscode

COPY ./vm/start.sh /etc/start.sh
CMD /etc/start.sh
