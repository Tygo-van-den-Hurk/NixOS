{
  imports = [
    ./search-firefox-addon
    ./apply.nix
  ];

  perSystem = { self', ... }: {
    apps.default = self'.apps.apply;
  };
}
