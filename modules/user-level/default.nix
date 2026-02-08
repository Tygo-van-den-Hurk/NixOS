## imports all the user level modules in this directory as specified by the machine-settings.
#! breaking this file could break multiple systems. Only remove modules if you are sure they are unused by all systems.
_:
(builtins.trace "(System) Loading: ${toString ./.}..." {
  imports = [
    ./docker
    ./home-manager
    ./key-remapper
    ./virtualbox
  ];
})
