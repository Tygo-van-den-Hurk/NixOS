## Defines the services that run on the system.

arguments @ { config, pkgs, lib, machine-settings, ... } : { services.xserver.windowManager = {
    };

    imports = [
        ( import ./i3 arguments )
    ];
}
