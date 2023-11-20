#!/bin/bash
set -ex

npm install --global serve
serve -p 7123 &
sleep 3 # let server get ready

export BUNW_DL_BASE_URL="http://localhost:7123/"

if [[ $OS == Windows_NT ]]; then
  pwsh -Command "irm ${BUNW_DL_BASE_URL}install.ps1 | iex"
fi

curl -fsSL ${BUNW_DL_BASE_URL}install.sh | sh

./bunw -e 'console.log("Hello world!")'
./bunw -e 'console.log(Bun.version)'
