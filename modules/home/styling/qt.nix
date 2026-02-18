{
  lib,
  config,
  ...
}:
with lib;
let
  category = "qt";
  type = "styling";
  cfg = config.${type}.${category};
in
{
  options.${type}.${category} = with types; {
    enable = mkOption {
      description = "Whether to enable styling using the ${category} framework.";
      default = config.${type}.enable;
      type = bool;
    };
  };

  config.${category} = mkIf cfg.enable {
    enable = mkDefault true;
  };
}
