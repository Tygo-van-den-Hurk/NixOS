echo "1) Updating flake inputs:"
nix flake lock \
  --update-input tygo-van-den-hurk-dotfiles \
  --update-input tygo-van-den-hurk-secrets

echo "2) rebuilding system:"
sudo nixos-rebuild switch --flake .# --show-trace
