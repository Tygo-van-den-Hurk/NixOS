## Defines display manager / window manager settings.

arguments @ { config, pkgs, lib, machine-settings, ... } : {
  
  security.sudo = {
    wheelNeedsPassword = lib.mkDefault true;
    extraConfig = lib.mkDefault "Defaults pwfeedback";
  };

}

