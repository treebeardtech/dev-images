ARG VARIANT="3.13"
FROM mcr.microsoft.com/devcontainers/python:${VARIANT}

ARG INSTALL_NODE="true"
ARG NODE_VERSION="lts/*"
RUN if [ "${INSTALL_NODE}" = "true" ]; then su vscode -c "source /usr/local/share/nvm/nvm.sh && nvm install ${NODE_VERSION} 2>&1"; fi

RUN pip3 --disable-pip-version-check --no-cache-dir install uv

RUN uv pip install --system --no-cache \
  ipykernel \
  jupyter \
  nbstripout \
  pre-commit \
  ruff

RUN su vscode -c "source /usr/local/share/nvm/nvm.sh && npm install -g @anthropic-ai/claude-code 2>&1"

# prevent homebrew from updating or upgrading to save time
ENV HOMEBREW_NO_AUTO_UPDATE=1
ENV HOMEBREW_NO_INSTALL_UPGRADE=1

WORKDIR /tmp
RUN curl \
  -Lk \
  'https://code.visualstudio.com/sha/download?build=stable&os=cli-alpine-x64' \
  --output vscode_cli.tar.gz
RUN rm -f /usr/local/bin/code
RUN tar -xf vscode_cli.tar.gz -C /usr/local/bin

ENV TUNNEL_NAME=runpod
ENV VSCODE_CLI_USE_FILE_KEYCHAIN=true

WORKDIR /home/vscode

COPY ./vm/start.sh /etc/start.sh
CMD /etc/start.sh
