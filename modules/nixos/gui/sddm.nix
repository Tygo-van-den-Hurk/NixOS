{
  config,
  pkgs,
  lib,
  ...
}:
with lib;
let
  namespace = "self";
  module = "gui";
  submodule = "sddm";
  cfg = config.${namespace}.${module}.${submodule};
in
{
  options.${namespace}.${module}.${submodule} = with types; {
    enable = mkOption {
      description = "Whether to this module.";
      default = config.${namespace}.${module}.enable;
      type = bool;
    };

    theme = mkOption {
      description = "The ${submodule} theme package.";
      default = "sddm-astronaut-theme";
      type = str;
    };

    packages = mkOption {
      description = "The ${submodule} theme package.";
      type = listOf package;
      default = with pkgs; [
        sddm-astronaut # TODO: use `config.stylix.image` instead of this test:
      ];
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = cfg.packages;
    services.displayManager.sddm = {
      enable = mkDefault true;
      autoNumlock = mkDefault true;
      theme = mkDefault cfg.theme;
      extraPackages = cfg.packages;
      wayland.enable = mkDefault true;
    };
  };
}
