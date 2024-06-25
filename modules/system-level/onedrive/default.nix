## This module enables onedrive on the system https://nixos.wiki/wiki/OneDrive

arguments @ { config, pkgs, lib, machine-settings, ... } : let
 
    module-settings = machine-settings.system.modules.onedrive; 

in ( if ( module-settings.enable == true ) then builtins.trace "Loading: ${toString ./.}... " {

    services.onedrive.enable = true;

} else {} )
