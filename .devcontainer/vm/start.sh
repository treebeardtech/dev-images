#! /usr/bin/env bash

set -e -u -o pipefail -x

[ "$(stat -c %U .)" = "root" ] && sudo chown vscode:vscode /home/vscode

yes | \
  code tunnel \
    --accept-server-license-terms \
    --name ${TUNNEL_NAME} \
    --cli-data-dir /home/vscode/.vscode-cli
