{
  pkgs,
  lib,
  config,
  system,
  ...
}:
with lib;
let
  type = "gui";
  category = "messengers";
  program = "whatsapp";
  cfg = config.${type}.${category}.${program};
in
{
  options.${type}.${category}.${program} = with types; {
    enable = mkOption {
      description = "Whether to enable ${program}'s default config.";
      default = config.${type}.${category}.enable;
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
