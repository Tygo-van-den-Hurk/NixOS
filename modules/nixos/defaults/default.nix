_:

{
  flake.nixosModules.defaults =
    {
      lib,
      ...
    }:
    let
      inherit (lib) mkOption;
      inherit (lib) types;
      inherit (types) bool;

      module = "defaults";
    in
    {
      options.${module}.enable = mkOption {
        description = "Whether to this module.";
        default = true;
        readOnly = true;
        type = bool;
      };

      imports = [
        ./boot.nix
        ./fonts.nix
        ./locale.nix
        ./nix.config.nix
        ./secrets.nix
        ./security.nix
        ./services.nix
        ./user.nix
      ];
    };
}
