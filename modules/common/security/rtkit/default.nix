## Defines display manager / window manager settings.
#? unknown setting, but was here when I booted.
arguments @ { config, pkgs, lib, machine-settings, ... } : ( builtins.trace "Loading: ${toString ./.}..." { 
     
    security.rtkit = {
        enable = lib.mkDefault true;
    };
})
