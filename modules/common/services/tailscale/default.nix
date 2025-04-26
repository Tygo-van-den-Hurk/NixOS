## Defines the tailscale service.

arguments @ { config, pkgs, lib, machine-settings, ... } : {
    
  services.tailscale.enable = lib.mkDefault true;
  
  environment.systemPackages = [ pkgs.tailscale ];

  networking.firewall.checkReversePath = lib.mkDefault "loose"; # Fix for TailScale

}
