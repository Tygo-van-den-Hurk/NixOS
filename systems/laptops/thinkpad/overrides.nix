## Defines the configuration options for this machine.
#! You should not have to change this file, all changes should happen in either the modules, or the settings.
arguments @ { config, pkgs, lib, programs, input, ... } : { 

    # TODO : Remove in a couple of reboots. 
    # As suggested here: https://discourse.nixos.org/t/rebuild-error-failed-to-start-network-manager-wait-online/41977
    systemd.network.wait-online.enable = (lib.mkForce false);
    boot.initrd.systemd.network.wait-online.enable = (lib.mkForce false);
}
