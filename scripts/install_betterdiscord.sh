#!/usr/bin/env bash

set -Eeu

mkdir -p ~/.local/bin/

# Install betterdiscordctl
curl 'https://raw.githubusercontent.com/bb010g/betterdiscordctl/master/betterdiscordctl' \
  -o ~/.local/bin/betterdiscordctl
chmod +x ~/.local/bin/betterdiscordctl

# Install BetterDiscord
~/.local/bin/betterdiscordctl reinstall

# Remove the enforced frame from the Electron config
sed -i \
  's/^[ \t]*if (process.platform !== "win32" && process.platform !== "darwin") config.frame = true;//' \
  ~/.local/share/betterdiscordctl/bd/0/index.js
