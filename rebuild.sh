#!/bin/sh

echo "Rebuilding OS from config in: $(dirname "$(readlink -f "$0")")"
sudo nixos-rebuild switch -I nixos-config="$(dirname "$(readlink -f "$0")")"
