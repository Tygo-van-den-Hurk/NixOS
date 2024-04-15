{
    description = "The flake that is used to configure all my machines.";
  
    #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ INPUTS ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#

    inputs = {
        nixpkgs.url = github:nixos/nixpkgs?ref=nixos-unstable;
        home-manager = {
            url = github:nix-community/home-manager;
            inputs.nixpkgs.follows = "nixpkgs";
        };
    };

    #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ OUTPUTS ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#

    outputs = { self, nixpkgs, home-manager, ... } : let
        lib = nixpkgs.lib;
       pkgs = import nixpkgs;
    in { nixosConfigurations = { #` Systems
            
            tygos-desktop = lib.nixosSystem { 
                modules = [ 
                    ./systems/desktops/home/configuration.nix 
                ];
            };

           tygos-thinkpad = lib.nixosSystem { 
                modules = [ 
                    ./systems/laptops/thinkpad/configuration.nix 
                ]; 
            };

            default = { # TODO : make this throw an error when loaded as this is not a system
                # assert false || throw "Did not specify hostname. 
                #     Please run the command ending in `.#hostname` 
                #     where hostname is the hostname of the system 
                #     you would like to load.";
            };
        };

        #` Home manager
        hmConfig = {

        };     
    };
}
