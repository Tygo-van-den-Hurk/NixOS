## Add fonts to the system.

arguments @ { config, pkgs, lib, machine-settings, ... } : ( builtins.trace "(System) Loading: ${toString ./.}..." { 
    
    fonts.packages = with pkgs; [
        open-dyslexic
        nerdfonts
    ];

})
 