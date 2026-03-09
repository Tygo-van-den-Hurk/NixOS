{ ... }:
{
  imports = [
    ./apply
    ./search-firefox-addon
  ];

  perSystem =
    { self', ... }:
    {
      apps.default = self'.apps.apply;
    };
}
