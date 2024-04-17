## Defines the services that run on the system.

arguments @ { config, pkgs, lib, machine-settings, ... } : { services.xserver.desktopManager = {
    };

    imports = [
        ( import ./plasma5 arguments )
        ( import ./xterm   arguments )
    ];
}
