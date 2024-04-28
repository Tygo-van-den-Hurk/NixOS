## imports the right GUI as specified by the machine-settings.
#! breaking this file could break multiple systems. Only remove modules if you are sure they are unused by all systems.
arguments @ { config, pkgs, lib, machine-settings, programs, ... } : let 
  
    importNothing = {};
    __keyRemapper_ = ( machine-settings.modules.key-remapper );

    #! make sure that the variable that `builtins.trace` assigns get used to trigger the print.
    #` this is because `builtins.trace` only prints a trace on the output if the variable gets used.
    #` that's why you have to go through hoops and bounds to get this variable used so that it prints the message.
    key-remapper = ( 
        builtins.trace "Loading: /modules/key-remapper... ( key-remappers requested: ${__keyRemapper_} )" 
        __keyRemapper_
    ); 

in 

#! The key-remapper must be specified in the variable !#
assert ( key-remapper != "" && key-remapper != false); 
#! The key-remapper must be specified in the variable !#

{ 
    imports = [(    

        if ( key-remapper == "kmonad" ) then ( import ./kmonad arguments ) else
        if ( key-remapper == "xremap" ) then ( import ./xremap arguments ) else 
        if ( key-remapper == false    ) then ( importNothing             ) else
        abort "Error: \"${key-remapper}\" is not one of the supported key-remappers."

    )];
}
