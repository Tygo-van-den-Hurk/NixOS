## Defines the services that run on the system.

{ config, pkgs, lib, ... } : { services = {

        #` Printing
        # Enable CUPS to print documents.
        printing.enable = true;
    };

    imports = [ 
        ./openssh
        ./pipewire
        ./printing
        ./xserver
    ]; 

}
