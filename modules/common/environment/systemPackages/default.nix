## Defines the packages to use on the system.

arguments @ { config, pkgs, lib, machine-settings, ... } : let 

    #! make sure that the variable that `builtins.trace` assigns get used to trigger the print.
    #` this is because `builtins.trace` only prints a trace on the output if the variable gets used.
    #` that's why you have to go through hoops and bounds to get this variable used so that it prints the message.
    packages = builtins.trace ("Loading: ${toString ./.}...") (
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
        wget                    # get files
        curl                    # Make HTTP requests
        git gh glab             # for Git
        lf                      # ?unknown?
        fzf                     # find a file or folder very quickly
        tailscale               # A private network of all my devices
        lshw                    # For seeing connected devices
        yt-dlp                  # Downloading Youtube video's
        octaveFull              # Open Source version of MathLab
        zoxide                  # A beter way of doing `cd`.
        bat                     # A beter way of doing `cat`. #TODO : make an alias for 'cat' to 'bat --paging=never'.

        #| Terminal user interfaces
        lazygit                 # A TUI for interacting with git
        micro                   # The supirior option for editing text in the terminal over Nano
        vim                     # An advance TUI for editing text.
        neovim                  # A more extensible version of vim

        #` 2) File Editing
        
        #|Text/Code editors
        kate                    # A basic GUI for editing text.
        vscode                  # A code editor
        obsidian                # A markdown editor

        #| Programming languages
        rustc rustup cargo      # For Rust development
        
        #| Document editing
        onlyoffice-bin
        libreoffice-qt

        #| Spell Checkers
        hunspell
        hunspellDicts.uk_UA
        hunspellDicts.th_TH
        
        #| Picture Editors
        gimp                    # For editing photos

        #` 3) Web browsers
        firefox brave

        #` 4) Communication
        telegram-desktop
        signal-desktop
        thunderbird
        discord
	    whatsapp-for-linux

        #` 5) Files and VM's
        xfce.thunar             # A GUI file manager

        #` *) others
        localsend
        stow                    # A symlink farmer to be able to sent your dot files as symlinks from any place to the repository
        obs-studio              # for recording your screen or window
    ]) 
    # ++ ( user-defined-free-packages ) ++ ( # TODO : Set up settings defined packages.
    #     if ( packages.allowUnfree ) then ( user-defined-unfree-packages ) else ( do-not-add-unfree-packages ) 
    # )
    ;
}
