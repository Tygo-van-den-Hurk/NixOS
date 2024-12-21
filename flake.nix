{
  description = "The flake that is used to configure all my machines.";

  inputs  = {
  
    #| Nix Packages (Where all your packages come from)
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    
    # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Home Manager ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ #

    #| Home Manager (Declaratively create dot files)
    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    #| Stylix (Manage theming for home manager)
    stylix = { #! url updated from "github:danth/stylix", see `https://github.com/danth/stylix/issues/577`:
      url = "github:danth/stylix/cf8b6e2d4e8aca8ef14b839a906ab5eb98b08561"; #
      inputs.nixpkgs.follows = "nixpkgs";
    };

    #` Tygo van den Hurk's Dotfiles
    tygo-van-den-hurk-dotfiles= {
      url = "git+file:./modules/user-level/home-manager/tygo-van-den-hurk";
      flake = false;
    };

    # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Secret Management ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ #
    
    #| SOPS (Secret management)
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    #` Tygo van den Hurk's Secrets
    tygo-van-den-hurk-secrets = {
      url = "git+file:./modules/common/sops/tygo-van-den-hurk";
      flake = false;
    };
    
    # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Miscellaneous ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ #

    #| WSL (Window SubSystem for Linux)
    nixos-wsl = {
      url = "github:nix-community/NixOS-WSL/main";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    #| Zen Browser (a Arc inspired FireFox)
    # zen-browser.url = "github:MarceColl/zen-browser-flake"; # Stuck at 1.0.1.a6
    zen-browser.url = "github:ch4og/zen-browser-flake";

    #| NUR (NixOS User Repository)
    nur.url = "github:nix-community/NUR";

    #| Xremap (Easy keyremapping)
    xremap.url = "github:xremap/nix-flake";

    #| Disko (Declarative disk partitioning & disk wiping)
    # disko = {
    #   url = "github:nix-community/disko";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };

    #| Nix Index Database (Replaces the program not found message)
    # nix-index-database = {
    #   url = "github:Mic92/nix-index-database";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
  };

  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ OUTPUTS ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
  outputs = input @ { self, nixpkgs, nur, home-manager, stylix, nixos-wsl, ...  } : let
      
    #| Getting the NixOS hosts
    nixosConfigurations = let 
      __nixosConfigurations_ = ( import ./systems/get.nix { inherit input; root-directory-repository = ./.; } );
      avalible-system-names = (nixpkgs.lib.attrNames __nixosConfigurations_);
      sperator = ("\n\t - ");
      avalible-systems-string = (builtins.concatStringsSep sperator avalible-system-names);
    in (builtins.trace "Avalible systems:${sperator+avalible-systems-string}" __nixosConfigurations_ );
      
  in { inherit nixosConfigurations; };
}
