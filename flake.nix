{
    description = "The flake that is used to configure all my machines.";
    #
    #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ INPUTS ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
    #
    # I this block we define the inputs of the flake, these inputs are other flakes. So for example the Nix packages is
    # it self a flake, and we pass this down as `pkgs`, and `lib`. We can also add other repositories, or applications.
    #
    inputs = {

        #| Nix Packages (Where all your packages come from)
        nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";
        nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
        
        #| Home Manager (Declaratively create dot files)
        home-manager.url = "github:nix-community/home-manager/release-23.11";
        home-manager.inputs.nixpkgs.follows = "nixpkgs";

        #| WSL (Window SubSystem for Linux)
        nixos-wsl.url = "github:nix-community/NixOS-WSL";
        nixos-wsl.inputs.nixpkgs.follows = "nixpkgs";

        #|? Unknown
        # nix-index-database.url = "github:Mic92/nix-index-database";
        # nix-index-database.inputs.nixpkgs.follows = "nixpkgs";
        
        #| Disko (Declarative disk partitioning & disk wiping)
        # disko.url = "github:nix-community/disko";
        # disko.inputs.nixpkgs.follows = "nixpkgs";

        #| NUR (NixOS User Repository)
        nur.url = "github:nix-community/NUR";

        #| Xremap (Easy keyremapping)
        xremap-flake.url = "github:xremap/nix-flake";
    };
    #
    #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ OUTPUTS ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
    #
    # In this portion we'll modify the iputs to get an output, we you use the command:
    # 
    #?   sudo nixos-rebuild switch --flake .#[hostname]
    #
    # it will look look for this object:
    #
    #?   outputs.nixosConfigurations.[hostname]
    #
    # and create a working system from that.
    #
    # This is where we'll use it
    outputs = ( input @ { home-manager, nixos-wsl, nixpkgs, self, nur, ...  } : let
    
        __nixosConfigurations_ = ( import ./systems/get.nix { inherit input; } );
        nixosConfigurations = let 
        
            avalible-system-names = (nixpkgs.lib.attrNames __nixosConfigurations_);
            sperator = ("\n\t - ");
            avalible-systems-string = (builtins.concatStringsSep sperator avalible-system-names);

        in (builtins.trace
            "Avalible systems:${sperator+avalible-systems-string}"
            __nixosConfigurations_
        );
    
    in { inherit nixosConfigurations; }
    );
}
