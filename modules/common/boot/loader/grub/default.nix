## Defines all the settings for the grub boot loader.
#! Cannot be enabled if systemd-boot is enabled.
arguments @ { config, pkgs, lib, machine-settings, ... } : let 

  custom-theme =  ( pkgs.sleek-grub-theme.override {
    withBanner = machine-settings.system.hostname;
    withStyle  = "dark";
  }); 

in { 
    
  boot.loader.grub = {
    theme       = (lib.mkDefault custom-theme);
    enable      = (lib.mkDefault true);
    useOSProber = (lib.mkDefault true);
    efiSupport  = (lib.mkDefault true);
    devices     = [ "nodev" ]; 
  };

}
