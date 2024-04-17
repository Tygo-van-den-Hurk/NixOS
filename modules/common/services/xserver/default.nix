## Defines the services that run on the system.

arguments @ { config, pkgs, lib, machine-settings, ... } : { services.xserver = {
        enable = true;
        layout = "us";
        xkbVariant = "";
    };

    imports = [
        ( import ./desktopManager arguments )
        ( import ./displayManager arguments )
        ( import ./libinput       arguments )
        ( import ./windowManager  arguments )
    ];
}
