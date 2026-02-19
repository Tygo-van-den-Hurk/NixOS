{
  description = "The flake that is used to configure all my NixOS machines.";

  # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Packages ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ #

  # A collection of packages for the Nix package manager
  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";

  # A collection of packages for the Nix package manager
  inputs.nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

  # NUR (NixOS User Repository)
  inputs.nur = {
    url = "github:nix-community/NUR";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  # Zen Browser (a Arc inspired FireFox based browser)
  inputs.zen-browser = {
    url = "github:0xc000022070/zen-browser-flake";
    inputs.nixpkgs.follows = "nixpkgs";
    inputs.home-manager.follows = "home-manager";
  };

  # A wrapper tool for nix OpenGL applications
  inputs.nixGL = {
    url = "github:nix-community/nixGL";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Home Manager ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ #

  # Home Manager (Declaratively create dot files)
  inputs.home-manager = {
    url = "github:nix-community/home-manager/release-25.11";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  # Theming framework for NixOS, Home Manager, nix-darwin, and Nix-on-Droid
  inputs.stylix = {
    url = "github:nix-community/stylix/release-25.11";
    inputs.nixpkgs.follows = "nixpkgs";
    inputs.flake-parts.follows = "flake-parts";
    inputs.nur.follows = "nur";
  };

  # My personal dotfiles
  inputs.tygo-van-den-hurk-dotfiles = {
    url = "github:Tygo-van-den-Hurk/dotfiles?ref=feat/use-home-manager";
    inputs.nixpkgs.follows = "nixpkgs";
    inputs.nixpkgs-unstable.follows = "nixpkgs-unstable";
    inputs.pre-commit-hooks.follows = "git-hooks-nix";
    inputs.nix-github-actions.follows = "nix-github-actions";
    inputs.flake-compat .follows = "flake-compat";
    inputs.treefmt-nix.follows = "treefmt-nix";
    inputs.home-manager.follows = "home-manager";
    inputs.stylix.follows = "stylix";
  };

  # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Secret Management ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ #

  # Integrates SOPS into NixOS (Secret management)
  inputs.sops-nix = {
    url = "github:Mic92/sops-nix";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  # Tygo van den Hurk's Secrets
  inputs.tygo-van-den-hurk-secrets = {
    url = "git+ssh://git@github.com/Tygo-van-den-Hurk/Secrets-NixOS?ref=main";
    flake = false;
  };

  # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Utilities ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ #

  # Generate Github Actions matrices from Nix Flakes
  inputs.nix-github-actions.url = "github:nix-community/nix-github-actions";

  # Flake basics described using the module system
  inputs.flake-parts.url = "github:hercules-ci/flake-parts";

  # Allow flakes to be used with Nix < 2.4
  inputs.flake-compat = {
    url = "github:edolstra/flake-compat";
    flake = false;
  };

  # treefmt nix configuration modules
  inputs.treefmt-nix = {
    url = "github:numtide/treefmt-nix";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  # Seamless integration of https://pre-commit.com git hooks with Nix.
  inputs.git-hooks-nix = {
    url = "github:cachix/git-hooks.nix";
    inputs.flake-compat.follows = "flake-compat";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Miscellaneous ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ #

  # Hyprland is a dynamic tiling Wayland compositor that doesn't sacrifice on its looks
  inputs.hyprland = {
    url = "github:hyprwm/Hyprland";
    inputs.nixpkgs.follows = "nixpkgs";
    inputs.pre-commit-hooks.follows = "git-hooks-nix";
  };

  # Makes the whole file system ephemeral by default.
  inputs.impermanence = {
    url = "github:nix-community/impermanence";
    inputs.home-manager.follows = "home-manager";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  # NixOS on WSL (Window SubSystem for Linux)
  inputs.nixos-wsl = {
    url = "github:nix-community/NixOS-WSL/main";
    inputs.nixpkgs.follows = "nixpkgs";
    inputs.flake-compat.follows = "flake-compat";
  };

  # Adds options for Xremap, a key remapper for Linux
  inputs.xremap = {
    url = "github:xremap/nix-flake";
    inputs.nixpkgs.follows = "nixpkgs";
    inputs.flake-parts.follows = "flake-parts";
  };

  # Declarative disk partitioning & disk wiping
  inputs.disko = {
    url = "github:nix-community/disko";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  # Nix Index Database (Replaces the program not found message)
  inputs.nix-index-database = {
    url = "github:nix-community/nix-index-database";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Outputs ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ #

  outputs =
    inputs:
    inputs.flake-parts.lib.mkFlake { inherit inputs; } {

      imports = [
        ./apps
        ./checks
        ./ci
        ./homes
        ./formatting
        ./git-hooks
        ./hosts
        ./lib
        ./modules
        ./overlays
        ./packages
        ./shells
      ];

      systems = [
        "aarch64-darwin"
        "aarch64-linux"
        "x86_64-darwin"
        "x86_64-linux"
      ];

      # perSystem = { system, self', ... }: {
      #   _module.args.pkgs = import inputs.nixpkgs {
      #     inherit system;
      #     overlays = [self'.overlays.unstable-packages];
      #     config = {
      #       allowUnfree = true;
      #     };
      #   };
      # };
    };

  # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ #
}
