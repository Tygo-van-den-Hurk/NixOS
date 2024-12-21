## Defines the packages to use on the system.

arguments @ { config, pkgs, lib, machine-settings, ... } : ( builtins.trace "(System) Loading: ${toString ./.}..." { 

  environment.systemPackages = with pkgs; [

    #` 1) Terminals & Command Line Tools
        
    #| Terminals
    xterm                   # A terminal emulator
    kitty                   # A terminal emulator
    alacritty               # A terminal emulator

    #| Command Line Tools
    wget                    # get files.
    curl                    # Make HTTP requests.
    git-filter-repo         # Quickly rewrite git repository history.
    git gh glab             # for version control (Git).
    fzf                     # find a file or folder very quickly.
    tailscale               # A private network of all my devices.
    lshw                    # For seeing connected devices.
    yt-dlp                  # Downloading Youtube video's.
    zoxide                  # A beter way of doing `cd`.
    bat                     # A beter way of doing `cat`.
    eza                     # A beter way of doing `ls`.
    zip unzip               # For Working with ZIP archives.
    tiv                     # a program that gives a preview of image files, right in the terminal.
    imagemagick             # A software suite to create, edit, compose, or convert bitmap images.
    dig                     # For doing DNS queries.
    busybox                 # a bunch of CLI tools that come in handy.
    jq                      # for dealing with JSON data in the command line.

    #| Terminal user interfaces
    lazygit                 # A TUI for interacting with git
    micro                   # The supirior option for editing text in the terminal over Nano
    vim                     # An advance TUI for editing text.
    neovim                  # A more extensible version of vim
    lf                      # A terminal file manager
    pop                     # sent emails from the CLI
    (octave.withPackages (  # Open Source version of MathLab
      octavePackages:       # ( Adding some extentions to octave )
      with octavePackages; [ 
        symbolic            # Adds the ability for symbolic variables and caclulations to Octave
        linear-algebra      # Adds more linear algebra functions to Octave
      ]
    ))

    #| Ricing
    cmatrix                 # A program that displays random floating characters like in the matrix
    cowsay                  # A program that displays an animal saying what you want it to say
    cava                    # A program that displays audio bars in real time
    fastfetch               # A program that displays system statistics
    pipes                   # A program that displays random forming pipes 

    #` 2) File Editing
    
    #|Text/Code editors
    kate                    # A basic GUI for editing text.
    vscode                  # A code editor
    obsidian                # A markdown editor

    #| Programming languages
    #! All programming dependancies should be in a shell.nix or flake.nix file to prevent version mismatches.

    #| Document editing
    onlyoffice-bin          # An open source document suite
    libreoffice-qt          # An open source document suite

    #| Spell Checkers
    hunspell                # A free and opensource spell checker
    hunspellDicts.uk_UA     # English spell checker
    hunspellDicts.nl_NL     # Dutch spell checker
    
    #| Picture Editors
    gimp                    # For editing photos

    #` 3) Viewing reference material

    #| Viewing web pages
    firefox                 # A non-chromium based broweser, and my browser of choice
    brave                   # A chromium based broweser with build in add blocking

    #| viewing pdfs
    zathura                 # Allows for opening PDF documents without bloat

    #` 4) Communication
    telegram-desktop        # A popular private messaging platform
    signal-desktop          # A popular private messaging platform
    thunderbird             # A popular opensource email client
    discord                 # A messaging platform
    whatsapp-for-linux      # A messaging platform owned by facebook (meta)

    #` 5) Files and VM's
    xfce.thunar             # A GUI file manager

    #` *) others
    localsend               # A program that allows for sending files between devices regardless of OS
    stow                    # A symlink farmer I use for managing my dotfiles
    obs-studio              # For recording your screen or window
  ] ++ [
    
  ];
})
