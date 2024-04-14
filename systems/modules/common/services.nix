## Defines the services that run on the system.

{ config, pkgs, lib, ... } : { services = {

        # Enable the X11 windowing system.
        xserver.enable = true;

        # Enable the KDE Plasma Desktop Environment.
        xserver.displayManager.sddm.enable = true;
        xserver.desktopManager.plasma5.enable = true;
        xserver.displayManager.sddm.theme = "breeze";
        # xserver.displayManager.sddm.enableNumlock = true; # does not exist appearantly...?

        # Configure keymap in X11
        xserver.layout = "us";
        xserver.xkbVariant = "";
        xserver.libinput.enable = true; # Enable touchpad support (enabled default in most desktopManager).

        # Enable CUPS to print documents.
        printing.enable = true;
        
        pipewire.enable = true;
        pipewire.alsa.enable = true;
        pipewire.alsa.support32Bit = true;
        pipewire.pulse.enable = true;
        # pipewire.jack.enable = true; # If you want to use JACK applications, uncomment this
        # pipewire.media-session.enable = true;

        # Enable the OpenSSH daemon.
        openssh.enable = true;
    };
}
