## imports the right GUI as specified by the machine-settings.
#! breaking this file could break multiple systems. Only remove modules if you are sure they are unused by all systems.
arguments @ { config, pkgs, lib, machine-settings, ... } : let 
  
    gui = machine-settings.modules.gui; 
    error-message = ( "\"${machine-settings.modules.gui}\" is not one of the supported GUIs." );

in { imports = [(    

        /**/ if ( gui == "i3" || gui == "i3wm" ) then ( import ./i3wm      arguments ) 
        else if ( gui == "gnome"               ) then ( import ./gnome     arguments ) 
        else if ( gui == "kde" || gui == "KDE" ) then ( import ./kde       arguments )
        else if ( gui == "hyperland"           ) then ( import ./hyperland arguments )
        else abort error-message

    )];
}
