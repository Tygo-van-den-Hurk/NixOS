## Defines Hyperland settings.
#! This is just for non-NVIDIA users. If you have an NVIDIA GPU, you must add some patches. 
arguments @ { config, pkgs, lib, machine-settings, ... } : { # See https://www.youtube.com/watch?v=61wGzIv12Ds
    
    programs.hyperland.enable = true; # check '!' comment
    environment.systemPackages = with pkgs; [ waybar eww ];
}