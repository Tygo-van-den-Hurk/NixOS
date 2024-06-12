## Defines the packages to use on the system.

arguments @ { config, pkgs, lib, machine-settings, ... } : let 

    #! make sure that the variable that `builtins.trace` assigns get used to trigger the print.
    #` this is because `builtins.trace` only prints a trace on the output if the variable gets used.
    #` that's why you have to go through hoops and bounds to get this variable used so that it prints the message.
    packages = builtins.trace ("Loading: /modules/common/environment/systemPackages...") (
        machine-settings.system.packages
    ); 

in 

assert ( packages                != null ); # The packages set was not defined in the settings.
assert ( packages.allowUnfree    != null ); # The settings do not specify wether or not to allow unfree software.
# assert ( packages.freeSoftware   != null ); # The the free software to install.
# assert ( packages.unFreeSoftware != null ); # The the non-free software to install if allowed.

let 

    do-not-add-unfree-packages  = [];                       # explanation for a constant
    user-defined-unfree-packages = packages.unFreeSoftware; # explanation for a constant
    user-defined-free-packages   = packages.freeSoftware;   # explanation for a constant

in { environment.systemPackages = ( with pkgs; [

        #` 1) Terminals & Command Line Tools
        
        #| Terminals
        xterm 
        kitty
        alacritty

        #| Command Line Tools
        wget 
        curl
        git gh glab
        lf
        fzf
        ollama
        tailscale
        lshw
        yt-dlp

        #| Terminal user interfaces
        lazygit
        micro
        vim
        neovim

        #` 2) File Editing
        
        #|Text/Code editors
        kate        
        vscode
        
        #| Programming languages
        rustc rustup cargo
        
        #| Document editing
        onlyoffice-bin
        libreoffice-qt

        #| Spell Checkers
        hunspell
        hunspellDicts.uk_UA
        hunspellDicts.th_TH
        
        #| Picture Editors
        gimp

        #` 3) Web browsers
        firefox brave

        #` 4) Communication
        telegram-desktop
        signal-desktop
        thunderbird
        discord
	    whatsapp-for-linux

        #` 5) Files and VM's
        xfce.thunar

        #` *) others
        localsend
        stow 
        obs-studio
    ]) 
    # ++ ( user-defined-free-packages ) ++ ( # TODO : Set up settings defined packages.
    #     if ( packages.allowUnfree ) then ( user-defined-unfree-packages ) else ( do-not-add-unfree-packages ) 
    # )
    ;
}
