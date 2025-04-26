## Defines the services that run on the system.

arguments @ { config, pkgs, lib, machine-settings, ... } : {

  environment.systemPackages = with pkgs; [ espanso ];

  services.espanso = {
    enable = lib.mkDefault true;
  };

}
