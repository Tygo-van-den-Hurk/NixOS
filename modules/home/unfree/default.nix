_:
let
  namespace = "self";
  module = "unfree";
in
{
  flake.homeModules.${module} =
    {
      config,
      lib,
      ...
    }:
    with lib;
    {
      options.${namespace}.${module} = with types; {
        packageAllowList = mkOption {
          description = "The list of packages that are unfree to allow anyways.";
          type = listOf str;
          default = [ ];
        };
      };

      config.nixpkgs.config = {
        allowUnfreePredicate =
          pkg: builtins.elem (lib.getName pkg) config.${namespace}.${module}.packageAllowList;
      };
    };
}
