## Defines miscellaneous settings.

{ config, pkgs, lib, ... } : {

    # Enable sound with pipewire. 
    sound.enable = lib.mkDefault true;
    hardware.pulseaudio.enable = lib.mkDefault false;
    security.rtkit.enable = lib.mkDefault true;

    # Some programs need SUID wrappers, can be configured further or are
    # started in user sessions.
    # programs.mtr.enable = true;
    # programs.gnupg.agent = {
    #   enable = true;
    #   enableSSHSupport = true;
    # };

    # Allow unfree packages
    nixpkgs.config.allowUnfree = lib.mkDefault true;

    nix.settings.experimental-features = lib.mkForce [ "nix-command" "flakes" ];

    # Select internationalisation properties.
    i18n.defaultLocale = "en_US.UTF-8";
    i18n.extraLocaleSettings = {
        LC_ADDRESS = "nl_NL.UTF-8";
        LC_IDENTIFICATION = "nl_NL.UTF-8";
        LC_MEASUREMENT = "nl_NL.UTF-8";
        LC_MONETARY = "nl_NL.UTF-8";
        LC_NAME = "nl_NL.UTF-8";
        LC_NUMERIC = "nl_NL.UTF-8";
        LC_PAPER = "nl_NL.UTF-8";
        LC_TELEPHONE = "nl_NL.UTF-8";
        LC_TIME = "nl_NL.UTF-8";
    };
}