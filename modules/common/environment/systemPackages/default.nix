## Defines the packages to use on the system.

arguments @ { config, pkgs, lib, machine-settings, ... } : let 

    #! make sure that the variable that `builtins.trace` assigns get used to trigger the print.
    #` this is because `builtins.trace` only prints a trace on the output if the variable gets used.
    #` that's why you have to go through hoops and bounds to get this variable used so that it prints the message.
    ignore_me = builtins.trace ("Loading: /modules/common/environment/systemPackages...") ([]); 

in { environment.systemPackages = with pkgs; [

        #` Command Line Tools
        wget curl git gh lf fzf ollama tailscale

        #` Text/Code editors
        kate vim nano vscode
        
        #` Web browsers
        firefox brave

        #` Communication
        telegram-desktop thunderbird discord

        #` others
        localsend gimp stow
    ] ++ ignore_me;
}
