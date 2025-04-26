## Defines all the settings for the boot loader.

arguments @ { config, pkgs, lib, machine-settings, ... } : {

  imports = [ 
    ./efi 
    ./grub 
    ./systemd-boot
  ];

  boot.loader = {
    timeout = (lib.mkDefault 5);    
  };
  
}
