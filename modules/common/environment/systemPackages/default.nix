## Defines the packages to use on the system.

arguments @ { config, pkgs, lib, machine-settings, ... } : ( builtins.trace "Loading: ${toString ./.}..." { 
    
    environment.systemPackages = with pkgs; [

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

        #` 3) Viewing reference material

		#| Viewing web pages
        firefox 
        brave

		#| viewing pdfs
		zathura

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
    ];
})
