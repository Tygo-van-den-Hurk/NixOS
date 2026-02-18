{
  lib,
  config,
  ...
}:
with lib;
let
  type = "cli";
  category = "file-managers";
in
{
  options.${type}.${category} = with types; {
    enable = mkOption {
      description = "Whether to enable default config for the ${category} category.";
      default = config.${type}.enable;
      type = bool;
    };
  };
}
