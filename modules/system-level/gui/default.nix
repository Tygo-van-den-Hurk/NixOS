## imports the right GUI as specified by the machine-settings.
#! breaking this file could break multiple systems. Only remove modules if you are sure they are unused by all systems.
arguments @ { config, pkgs, lib, machine-settings, ... } : let 
    
    module-settings = machine-settings.system.modules.gui;  

in let

    enabled-GUIs = (lib.attrNames ( lib.attrsets.concatMapAttrs ( GUI-name: GUI-settings: 
        if (! builtins.isAttrs GUI-settings) then (
            abort (
                "The GUI attribute \"${GUI-name}\" found in machine settings is not a SET, "
                + "but a \"${builtins.typeOf GUI-settings}\". This is not expected, or allowed." )
        ) else if (GUI-settings.enable == true) then {
            "${GUI-name}" = GUI-settings.enable; 
        } else {}
    ) module-settings ));

    amount-of-GUIs-enabled = builtins.trace "MY TRACE: ${builtins.toJSON enabled-GUIs}" (builtins.length enabled-GUIs);
  
in ( if ( amount-of-GUIs-enabled > 1 ) then ( 
    
    let 
        sperator = ("\n\t - ");
        combined-list = (builtins.concatStringsSep sperator enabled-GUIs);
        enabled-GUIs-string = (sperator + combined-list);
        list-enabled-GUIs-string = ("Enabled GUIs:${enabled-GUIs-string}\nYou can only pick one GUI.");
    in abort ( "More then 1 GUI was selected." + list-enabled-GUIs-string)
    
) else if ( amount-of-GUIs-enabled > 0 ) then ( builtins.trace "Loading: ${toString ./.}..." { 
    
    imports = [
        ./i3wm
        ./gnome
        ./kde
        ./hyprland
    ];

}) else {})
 