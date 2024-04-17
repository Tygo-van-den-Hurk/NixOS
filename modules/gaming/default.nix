## Changes settings to enable gaming possiblities on this system.

{ config, pkgs, lib, machine-settings, ... } : {
    programs.gamemode.enable = lib.mkDefault true;
}
