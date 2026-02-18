{
  lib,
  config,
  ...
}:
with lib;
let
  category = "version-control";
  type = "cli";
in
{
  options.${type}.${category} = with types; {
    enable = mkOption {
      description = "Whether to enable ${program}'s default config.";
      default = config.${type}.enable;
      type = bool;
    };
  };

  imports = [
    ./git
    ./gh.nix
    ./gh-dash.nix
    ./lazygit.nix
  ];
}
