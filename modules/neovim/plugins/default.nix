{
  inputs,
  ...
}:
let
  inherit (inputs.self.lib) find-files;
  namespace = "self";
  module = "plugins";
in
{
  flake.neovimModules.${module} =
    {
      lib,
      ...
    }:
    with lib;
    {
      options.${namespace}.${module} = with types; {
        enable = mkOption {
          description = "Whether to turn on the language module.";
          default = false;
          type = bool;
        };
      };

      imports = find-files {
        base = ./.;
        exclude = ./default.nix;
        extension = ".nix";
      };
    };
}
