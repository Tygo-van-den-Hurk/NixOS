
# Initialize all submodules recursively
submodule-initialise:
	git submodule update --init --recursive

# Update the `tygo-van-den-hurk-dotfiles` submodule
submodule-update-tygo-van-den-hurk-dotfiles:
	nix flake update --override-input tygo-van-den-hurk-dotfiles ./modules/user-level/home-manager/tygo-van-den-hurk
	cd modules/user-level/home-manager/tygo-van-den-hurk && git pull origin main

# Update the `tygo-van-den-hurk-secrets` submodule
submodule-update-tygo-van-den-hurk-secrets:
	nix flake update tygo-van-den-hurk-secrets
	cd modules/common/sops/tygo-van-den-hurk && git pull origin main

# Update all submodules
submodule-update-all: submodule-update-tygo-van-den-hurk-dotfiles submodule-update-tygo-van-den-hurk-secrets

# Rebuild the NixOS system configuration
rebuild-system:
	git pull
	sudo nixos-rebuild switch --flake .# --show-trace

# Rebuild the system and update all submodules in one go
rebuild-complete: submodule-update-all rebuild-system