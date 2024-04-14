## Defines the packages to use on the system.

{ pkgs, ... } : { environment.systemPackages = with pkgs; [

        #` Command Line Tools
        wget curl git gh lf fzf ollama tailscale

        #` Text/Code editors
        kate vim nano vscode
        
        #` Web browsers
        firefox brave

        #` Communication
        telegram-desktop thunderbird discord

        #` others
        localsend gimp
    ];
}