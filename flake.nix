{
    description = "The flake that is used to configure all my machines.";
  
    #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ INPUTS ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
    #
    # I this block we define the inputs of the flake, these inputs are other flakes. So for example the Nix packages is
    # it self a flake, and we pass this down as `pkgs`, and `lib`. We can also add other repositories, or applications.
    #
    inputs = {

        #| Nix Packages
        nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";
        nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
        
        #| Home Manager
        home-manager.url = "github:nix-community/home-manager/release-23.11";
        home-manager.inputs.nixpkgs.follows = "nixpkgs";

        #| WSL (Window SubSystem for Linux)
        nixos-wsl.url = "github:nix-community/NixOS-WSL";
        nixos-wsl.inputs.nixpkgs.follows = "nixpkgs";

        #|? Unknown
        # nix-index-database.url = "github:Mic92/nix-index-database";
        # nix-index-database.inputs.nixpkgs.follows = "nixpkgs";
        
        #| Disko (Declarative disk partitioning)
        disko.url = "github:nix-community/disko";
        disko.inputs.nixpkgs.follows = "nixpkgs";

        #| NUR (NixOS User Repository)
        nur.url = "github:nix-community/NUR";
    };
    #
    #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ OUTPUTS ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
    #
    # In this portion we'll modify the iputs to get an output, we you use the command:
    # 
    #`   sudo nixos-rebuild switch --flake .#[hostname]
    #
    # it will look look for this object:
    #
    #`   outputs.nixosConfigurations.[hostname]
    #
    # and create a working system from that.
    #
    outputs = ( arguments @ { 
    
        home-manager, 
        nixos-wsl, 
        nixpkgs, 
        self, 
        nur, 
        ... 
    
    } : let

        lib = nixpkgs.lib;
       pkgs = import nixpkgs;
    
    in { 
        #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~` MACHINES `~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
        nixosConfigurations = {
            #
            # This is where the flake decided which system to load.
            #
            #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~| MACHINES |~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
            
            tygos-desktop  = lib.nixosSystem { modules = [ ./systems/desktops/home/configuration.nix    ]; };
            tygos-thinkpad = lib.nixosSystem { modules = [ ./systems/laptops/thinkpad/configuration.nix ]; };
            
            #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~| |~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
            #
            default = { # TODO : make this throw an error when loaded as this is not a system
                # assert false || throw "Did not specify hostname. 
                #     Please run the command ending in `.#hostname` 
                #     where hostname is the hostname of the system 
                #     you would like to load.";
            };
        };
        #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~` END OF MACHINES `~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
    });
}
