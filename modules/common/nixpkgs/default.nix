## Defines Nix packages configuration settings.

arguments @ { config, pkgs, lib, machine-settings, ... } : {
    
  imports = [ 
    ./config 
  ]; 

}
