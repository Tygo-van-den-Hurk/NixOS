arguments @ { input, ... } : 
# #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
let
            
    __pkgs_ = builtins.trace ( "Loading: Nix Packages (stable) from the input..." ) ( import input.nixpkgs { } );
    __pkgs_unstable_ = builtins.trace ( "Loading: Nix Packages (unstable) from the input..." ) ( import input.nixpkgs-unstable { } );
    pkgs = __pkgs_ // { unstable = __pkgs_unstable_; };

    lib = builtins.trace ( "Loading: Library from Nix Packages..."   ) ( input.nixpkgs.lib ); 

    # For debugging
    # lib = (import <nixpkgs> {}).lib;

in 
# #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
let 

    recursiveMerge = ( import ./recursive-merge.nix { inherit lib; } );
    nixosConfigurationsFilePaths = ( import ./list.nix );

in 
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ GETTING THE SETTINGS FOR A GIVEN MACHINE ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
let

    PathToSystem = ( pathToConfig : 
        
        #| import all levels of settings
        let

            __settings_ = {
                global   = ( import ( pathToConfig + "/../../common-settings.nix" ) );
                category = ( import ( pathToConfig + "/../common-settings.nix"    ) );
                machine  = ( import ( pathToConfig + "/settings.nix"              ) );
            };

        in 
        #| Adding a tracer to those values
        let 
            
            settings = {
                
                global   = (builtins.trace 
                    "Loading global settings:\n\t${builtins.toJSON __settings_.global}"
                    __settings_.global   
                );
                
                category = let 
                    categoryType = __settings_.category.system.type;
                in (builtins.trace 
                    "Loading category (${categoryType}) settings:\n\t${builtins.toJSON __settings_.category}"
                    __settings_.category
                );
                machine  = let 
                    machineName = __settings_.machine.system.hostname;
                in (builtins.trace 
                    "Loading machine (${machineName}) settings:\n\t${builtins.toJSON __settings_.machine}"
                    __settings_.machine  
                );
            };

        in
        #| Merge all settings into one
        let
            
            __machine-settings__ = ( recursiveMerge ( with settings; [ global category machine ] ) );

        in
        #| Adding pathToConfig to machine settings
        let
            
            machine-settings = ( __machine-settings__ // { inherit pathToConfig; });

        in
        #| Now create a blueprint from those settings
        let

            blueprint = let 
                message = (
                    "Creating blueprint for \"${machine-settings.system.hostname}\" with final settings:"
                    + "\n\t${builtins.toJSON machine-settings}"
                );
            in (builtins.trace message {
                
                    system = machine-settings.system.architecture;
                    specialArgs = { 
                        inherit input; 
                        inherit machine-settings;
                    };
                    
                    modules = [ 

                        ( machine-settings.pathToConfig + "/overrides.nix"               )
                        ( machine-settings.pathToConfig + "/hardware-configuration.nix"  )
                        ( ../modules )
                        
                        #` Custom input modules
                        input.nur.nixosModules.nur # Adding the NixOS User Repository
                    ];  
                }  
            );
            

        in  
        #| Create a system from that blueprint
        let
    
            nixosSystem = (lib.nixosSystem blueprint);

        in  
        #| create the pair (where the name is the hostname, and the value is the system)
        let

            result = let 
                name = machine-settings.system.hostname;
                value = nixosSystem;
            in ( lib.nameValuePair name value );

        in #| return:

        result
        
    );

in # ( PathToSystem ./laptops/thinkpad )
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ GOING OVER ALL THE PATHS TO A MACHINE ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
let
    
    PathsToSystems = ( paths :

        #| Creating all the systems out of the paths
        let

            # Set:{ name, value } <-- map( function, list )
            setOfSystems = ( builtins.map PathToSystem paths );
            
        in 
        #| Creating a set from that
        let
            
            # Set <-- List( Set:{ name, value } )
            result = ( builtins.listToAttrs setOfSystems );

        in #| return:

            result
    );

in # PathsToSystems [ ./laptops/thinkpad ./laptops/temp ]
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#

    PathsToSystems (nixosConfigurationsFilePaths)
