## Defines the printing service that runs on the system.

{ config, pkgs, lib, ... } : { services.printing = {
        enable = true;
    };
}
