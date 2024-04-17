## Defines the pipewire service.

arguments @ { config, pkgs, lib, machine-settings, ... } : { services.pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
        # jack.enable = true; # If you want to use JACK applications, uncomment this
        # media-session.enable = true;
    };
}
