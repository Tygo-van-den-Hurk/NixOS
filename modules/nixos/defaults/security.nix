{
  config,
  lib,
  ...
}:
let
  inherit (lib) mkOption;
  inherit (lib) mkIf;
  inherit (lib) mkDefault;
  inherit (lib) types;

  inherit (types) bool;

  module = "defaults";
  submodule = "security";
in
{
  options.${module}.${submodule} = {
    enable = mkOption {
      description = "Whether to load the default security settings.";
      default = config.${module}.enable;
      type = bool;
    };

    showPasswordLength = mkOption {
      description = "Whether to show the password length when running sudo.";
      default = config.${module}.${submodule}.enable;
      type = bool;
    };
  };

  config = mkIf config.${module}.${submodule}.enable {
    security.rtkit.enable = mkDefault true;
    security.sudo = {
      wheelNeedsPassword = mkDefault true;
      execWheelOnly = mkDefault true;
      extraConfig =
        if config.${module}.${submodule}.showPasswordLength then
          ''
            Defaults pwfeedback
          ''
        else
          "";
    };
  };
}
