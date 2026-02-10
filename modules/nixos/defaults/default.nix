_:
let
  module = "defaults";
in
{
  flake.nixosModules.${module} =
    {
      lib,
      ...
    }:
    with lib;
    {
      options.${module} = with types; {
        enable = mkOption {
          description = "Whether to load the defaults for all systems.";
          default = true;
          readOnly = true;
          type = bool;
        };
      };

      imports = [
        ./boot.nix
        ./fonts.nix
        ./locale.nix
        ./networking.nix
        ./nix.config.nix
        ./secrets.nix
        ./security.nix
        ./services.nix
        ./user.nix
      ];
    };
}
