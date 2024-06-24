## Changes settings to enable gaming possiblities on this system.

arguments @ { config, pkgs, lib, machine-settings, ... } : let 
    
    #! make sure that the variable that `builtins.trace` assigns get used to trigger the print.
    #` this is because `builtins.trace` only prints a trace on the output if the variable gets used.
    #` that's why you have to go through hoops and bounds to get this variable used so that it prints the message.
    yes = builtins.trace ("Loading: ${toString ./.}...") (true); 

in 

#! you CANNOT load this module without enabling unfree software !#
assert ( machine-settings.system.packages.allowUnfree == true );
#! you CANNOT load this module without enabling unfree software !#

{
    
    programs.gamemode.enable = lib.mkDefault yes;

    programs.steam = {
        enable = true;
        remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
        dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
    };

    environment.systemPackages = with pkgs; [
        steam
        # steam-original # is no longer needed? I think?
        steam-run
    ];
}
