{
  lib,
  config,
  ...
}:
with lib;
let
  type = "cli";
  category = "miscellaneous";
in
{
  options.${type}.${category} = with types; {
    enable = mkOption {
      description = "Whether to enable default config for the ${category} category.";
      default = config.${type}.enable;
      type = bool;
    };
  };

  imports = [
    ./starship
    ./bat.nix
    ./direnv.nix
    ./eza.nix
    ./fzf.nix
    ./onefetch.nix
    ./slack-term.nix
    ./zellij.nix
    ./zoxide.nix
  ];
}
