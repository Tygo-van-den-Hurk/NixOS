{
  config,
  lib,
  ...
}:
with lib;
let
  module = "defaults";
  submodule = "security";
  cfg = config.${module}.${submodule};
in
{
  options.${module}.${submodule} = with types; {
    enable = mkOption {
      description = "Whether to load the default security settings.";
      default = config.${module}.enable;
      type = bool;
    };

    showPasswordLength = mkOption {
      description = "Whether to show the password length when running sudo.";
      default = cfg.enable;
      type = bool;
    };
  };

  config = mkIf cfg.enable {
    security.rtkit.enable = mkDefault true;
    security.sudo = {
      wheelNeedsPassword = mkDefault true;
      execWheelOnly = mkDefault true;
      extraConfig =
        if cfg.showPasswordLength then
          ''
            Defaults pwfeedback
          ''
        else
          "";
    };
  };
}
