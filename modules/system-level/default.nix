## imports all the system level modules in this directory as specified by the machine-settings.
#! breaking this file could break multiple systems. Only remove modules if you are sure they are unused by all systems.
arguments @ { config, pkgs, lib, machine-settings, programs, input, ... } : let 

   # This is a hub for this type of module.

in { imports = [ ./local-ai ./nvidia ./podman ./power-efficiency ./wsl ]; }
  