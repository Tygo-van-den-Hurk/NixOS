{
  inputs,
  ...
}:
let
  inherit (inputs.nix-firefox-addons) packages;
in
{
  perSystem =
    {
      system,
      lib,
      ...
    }:
    with lib;
    {
      apps."search-firefox-addon" = mkIf (packages ? "${system}") {
        program = packages.${system}.search-addon;
        meta = packages.${system}.search-addon.meta;
        type = "app";
      };
    };
}
