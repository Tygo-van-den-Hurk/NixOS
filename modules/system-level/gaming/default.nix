## Changes settings to enable gaming possiblities on this system.

arguments @ { config, pkgs, lib, machine-settings, ... } : let 

    module-settings = machine-settings.system.modules.gaming;

in ( if module-settings.enable == true then builtins.trace "Loading: ${toString ./.}..." {
    
    programs.gamemode.enable = (lib.mkDefault true);

    programs.steam = {
        enable = (lib.mkDefault true);
        remotePlay.openFirewall = (lib.mkDefault true);
        dedicatedServer.openFirewall = (lib.mkDefault true);
    };

    environment.systemPackages = with pkgs; [
        steamPackages.steamcmd
        steam-tui
        steam
        steam-run
    ];

} else {} )
