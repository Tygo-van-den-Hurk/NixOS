{
    description = "The flake that is used to configure all my machines.";
  
    #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ INPUTS ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#

    inputs.nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

    #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ OUTPUTS ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#

    outputs = { self, nixpkgs, ... } : let
        lib = nixpkgs.lib;
       pkgs = import nixpkgs;
    in { nixosConfigurations = {
           tygos-thinkpad = lib.nixosSystem { modules = [ ./systems/laptops/thinkpad/configuration.nix ]; };
            tygos-desktop = lib.nixosSystem { modules = [ ./systems/desktops/home/configuration.nix ]; };
        };        
    };
}
