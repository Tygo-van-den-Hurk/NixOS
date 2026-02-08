## impors all the modules in this directory.
_:
(builtins.trace "(System) Loading: ${toString ./.}..." {
  imports = [
    ./boot
    ./console
    ./environment
    ./fonts
    ./hardware
    ./i18n
    ./networking
    ./nix
    ./nixpkgs
    ./security
    ./services
    ./sops
    ./system
    ./time
    ./users
  ];
})
