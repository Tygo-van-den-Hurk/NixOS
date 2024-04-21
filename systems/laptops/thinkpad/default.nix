## Defines the configuration options for this machine.
#! You should not have to change this file, all changes should happen in either the modules, or the settings.
arguments @ { config, pkgs, lib, programs, ... } : let

    recursiveMerge = ( builtins.trace ( "Merging settings..." ) ( import ../../recursive-merge.nix arguments_ ) );
    arguments_     = ( builtins.trace ( "Loading: system..."  ) ( arguments // { 
        machine-settings = final-machine-settings; 
    } ) ); 

    #| System Level Settings : will be overwritten by Category Settings, or by Machine Settings.
    __systemSettings_ = ( import ../../common-settings.nix arguments );
    system-settings = ( 
        builtins.trace "System Settings:\n\t${ builtins.toJSON __systemSettings_ }" 
        ( __systemSettings_ ) 
    );
    
    #| Category Level Settings : will be overwritten by Machine Settings.
    __categorySettings_ = ( import ../common-settings.nix arguments );
    category-settings = ( 
        builtins.trace "Category Settings:\n\t${ builtins.toJSON __categorySettings_ }" 
        ( __categorySettings_ ) 
    );


    #| Machine Level Settings : cannot be overwritten, and have the final say.
    __machineSettings_ = ( import ./settings.nix arguments );
    machine-settings = ( 
        builtins.trace "Machine Settings:\n\t${ builtins.toJSON __machineSettings_ }" 
        ( __machineSettings_ ) 
    );

    #| Final Settings : Merging the settings to one set. 
    __finalMachineSettings_ = ( recursiveMerge [ system-settings category-settings machine-settings ] );
    final-machine-settings = (
        builtins.trace "Final settings:\n\t${builtins.toJSON __finalMachineSettings_}" 
        (__finalMachineSettings_)
    );


in { imports = [ 
        ( import ./../../../modules  arguments_ )
        ./hardware-configuration.nix 
    ];
}
