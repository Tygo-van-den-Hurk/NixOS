nix flake lock --update-input tygo-van-den-hurk-dotfiles
sudo nixos-rebuild switch --flake .# --show-trace
