{ ... }:
{
  perSystem =
    { inputs', ... }:
    {
      apps.search-firefox-addon = {
        type = "app";
        program = inputs'.nix-firefox-addons.packages.search-addon;
        inherit (inputs'.nix-firefox-addons.packages.search-addon) meta;
      };
    };
}
