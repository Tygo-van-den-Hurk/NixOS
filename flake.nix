{
  description = "The flake that is used to configure all my machines.";

  inputs = {
    # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Packages ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ #

    # Nix Packages (Where all your packages come from)
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    # NUR (NixOS User Repository)
    nur = {
      url = "github:nix-community/NUR";
      inputs = {
        nixpkgs.follows = "nixpkgs";
      };
    };

    # Zen Browser (a Arc inspired FireFox based browser)
    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        home-manager.follows = "home-manager";
      };
    };

    # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Home Manager ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ #

    # Home Manager (Declaratively create dot files)
    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs = {
        nixpkgs.follows = "nixpkgs";
      };
    };

    # Stylix (Manage theming for home manager)
    stylix = {
      url = "github:danth/stylix/release-24.11";
      inputs = {
        nixpkgs.follows = "nixpkgs";
      };
    };

    # Tygo van den Hurk's Dotfiles
    tygo-van-den-hurk-dotfiles = {
      url = "github:Tygo-van-den-Hurk/dotfiles?ref=main";
      flake = false;
    };

    # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Secret Management ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ #

    # SOPS (Secret management)
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Tygo van den Hurk's Secrets
    tygo-van-den-hurk-secrets = {
      url = "git+ssh://git@github.com/Tygo-van-den-Hurk/Secrets-NixOS?ref=main";
      flake = false;
    };

    # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Miscellaneous ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ #

    # Flake Utils
    flake-utils.url = "github:numtide/flake-utils";

    # WSL (Window SubSystem for Linux)
    nixos-wsl = {
      url = "github:nix-community/NixOS-WSL/main";
      inputs = {
        nixpkgs.follows = "nixpkgs";
      };
    };

    # Xremap (Easy keyremapping)
    xremap = {
      url = "github:xremap/nix-flake";
    };

    # Disko (Declarative disk partitioning & disk wiping)
    disko = {
      url = "github:nix-community/disko";
      inputs = {
        nixpkgs.follows = "nixpkgs";
      };
    };

    # Nix Index Database (Replaces the program not found message)
    nix-index-database = {
      url = "github:Mic92/nix-index-database";
      inputs = {
        nixpkgs.follows = "nixpkgs";
      };
    };
  };

  #| ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ |#

  outputs = {
    self,
    nixpkgs,
    nixpkgs-unstable,
    nur,
    ...
  } @ inputs:
    inputs.flake-utils.lib.eachDefaultSystem (
      system: let
        pkgs = import nixpkgs {inherit system;};
        lib = nixpkgs.lib;
      in {
        # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Nix Fmt ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ #

        formatter = pkgs.alejandra;

        # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Nix Flake Check ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ #

        checks = let
          host-checks = builtins.listToAttrs (builtins.map (host: {
            name = "check-${host}";
            value = pkgs.runCommand "nixos-config-check-${host}" {} ''
              ${pkgs.nixos-rebuild}/bin/nixos-rebuild dry-activate --flake .#${host}
              touch $out
            '';
          }) (builtins.attrNames self.legacyPackages.${system}.nixosConfigurations));

          formatting = pkgs.runCommand "formatting-check" {} ''
            echo "Checking formatting of Nix files using $(${pkgs.alejandra}/bin/alejandra --version):"
            ${pkgs.alejandra}/bin/alejandra --check ${./.}
            touch $out
          '';
        in
          host-checks // {inherit formatting;};

        # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Nix Develop ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ #

        devShells.default = pkgs.mkShell {
          buildInputs = with pkgs; [treefmt];
          shellHook = ''
            # if the terminal supports color.
            if [[ -n "$(tput colors)" && "$(tput colors)" -gt 2 ]]; then
              export PS1="(\033[1m\033[35mDev-Shell\033[0m) $PS1"
            else
              export PS1="(Dev-Shell) $PS1"
            fi

            unset shellHook
            unset buildInputs
          '';
        };

        # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Nix Switch ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ #

        legacyPackages = let
          nixosConfigurations = import ./systems/get.nix {
            input = inputs;
            root-directory-repository = ./.;
          };
          avalible-system-names = nixpkgs.lib.attrNames nixosConfigurations;
          sperator = "\n  - ";
          avalible-systems-string = builtins.concatStringsSep sperator avalible-system-names;
        in (builtins.trace "Avalible systems:${sperator + avalible-systems-string}" {inherit nixosConfigurations;});

        # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ #
      }
    );
}
