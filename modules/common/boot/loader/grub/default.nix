## Defines all the settings for the grub boot loader.
#! Cannot be enabled if systemd-boot is enabled.
arguments @ { config, pkgs, lib, machine-settings, ... } : (builtins.trace "Loading: ${toString ./.}..." { 
    
    boot.loader.grub = let 
    
        grub-theme =  ( pkgs.sleek-grub-theme.override {
            withBanner = machine-settings.system.hostname;
            withStyle  = "dark";
        }); 

    in {
        theme = (lib.mkDefault grub-theme);
        enable         = (lib.mkDefault true);
        useOSProber    = (lib.mkDefault true);
        efiSupport     = (lib.mkDefault true);
        devices        = [ "nodev" ]; 
    };

})
