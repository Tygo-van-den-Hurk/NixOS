{
  pkgs,
  lib,
  config,
  system,
  ...
}:
with lib;
let
  namespace = "self";
  type = "gui";
  category = "messengers";
  program = "whatsapp";
  cfg = config.${namespace}.${type}.${category}.${program};
in
{
  options.${namespace}.${type}.${category}.${program} = with types; {
    enable = mkOption {
      description = "Whether to enable ${program}'s default config.";
      default = config.${namespace}.${type}.${category}.enable;
      type = bool;
    };
  };

  config.home = mkIf cfg.enable {
    packages = with pkgs; [
      (
        if hasSuffix "linux" system then
          wasistlos # used to be: whatsapp-for-linux
        else
          whatsapp-for-mac # might have moved?
      )
    ];
  };
}
