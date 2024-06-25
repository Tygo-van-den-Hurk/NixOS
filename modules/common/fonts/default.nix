## Add fonts to the system.

arguments @ { config, pkgs, lib, machine-settings, ... } : ( builtins.trace "Loading: ${toString ./.}..." { 
    
    fonts.packages = with pkgs; [
        open-dyslexic
        nerdfonts
    ];

})
 