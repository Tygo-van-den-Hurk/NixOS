{
  imports = [
    ./search-firefox-addon.nix
    ./apply.nix
  ];

  perSystem = { self', ... }: {
    apps.default = self'.apps.apply;
  };
}
