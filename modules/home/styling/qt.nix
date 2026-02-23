{
  lib,
  config,
  ...
}:
with lib;
let
  namespace = "self";
  category = "qt";
  type = "styling";
  cfg = config.${namespace}.${type}.${category};
in
{
  options.${namespace}.${type}.${category} = with types; {
    enable = mkOption {
      description = "Whether to enable styling using the ${category} framework.";
      default = config.${namespace}.${type}.enable;
      type = bool;
    };
  };

  config.${category} = mkIf cfg.enable {
    enable = mkDefault true;
  };
}
