#!/bin/sh

sudo chown -R "$(whoami)" /workspaces
curl -sfL https://direnv.net/install.sh | bash
direnv allow "$(git rev-parse --show-toplevel)"

# shellcheck disable=SC2016
echo 'eval "$(direnv hook bash)"' >>~/.bashrc

# shellcheck disable=SC2016
echo 'eval "$(direnv hook zsh)"' >>~/.zshrc
