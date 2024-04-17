## Defines the services that run on the system.

{ config, pkgs, lib, machine-settings, ... } : { services.xserver.windowManager = {
    };

    imports = [
        ./i3
    ];
}
