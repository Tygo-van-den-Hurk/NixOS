## Defines miscellaneous settings.

{ config, pkgs, lib, ... } : {

    # Enable sound with pipewire. 
    sound.enable = lib.mkDefault true;
    hardware.pulseaudio.enable = lib.mkDefault false;
    

    # Some programs need SUID wrappers, can be configured further or are
    # started in user sessions.
    # programs.mtr.enable = true;
    # programs.gnupg.agent = {
    #   enable = true;
    #   enableSSHSupport = true;
    # };

    # Allow unfree packages
    nixpkgs.config.allowUnfree = lib.mkDefault true;

    nix.settings.experimental-features = lib.mkForce [ 
        "nix-command" 
        "flakes" 
    ];

    
}