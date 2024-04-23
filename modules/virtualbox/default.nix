## installs virtual box, and configures the sytem to run it

arguments @ { config, pkgs, lib, machine-settings, programs, input, ... } : let 
    
    #! make sure that the variable that `builtins.trace` assigns get used to trigger the print.
    #` this is because `builtins.trace` only prints a trace on the output if the variable gets used.
    #` that's why you have to go through hoops and bounds to get this variable used so that it prints the message.
    yes = builtins.trace ("Loading: /modules/virtualbox...") (true); 

in { 

    nixpkgs.config.allowUnfree = lib.mkForce yes;
    environment.systemPackages = [ pkgs.virtualboxWithExtpack ];

    virtualisation.virtualbox.host.enable = yes;
    virtualisation.virtualbox.host.enableExtensionPack = yes;
    users.extraGroups.vboxusers.members = [ machine-settings.user.username ];

}
