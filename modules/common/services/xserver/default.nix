## Defines the services that run on the system.

{ config, pkgs, lib, ... } : { services.xserver = {
        enable = true;
        layout = "us";
        xkbVariant = "";
    };

    imports = [
        ./desktopManager
        ./displayManager
        ./libinput
    ];
}
