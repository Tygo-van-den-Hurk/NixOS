let
  namespace = "self";
  module = "xdg";
in
{
  flake.homeModules.${module} =
    {
      config,
      lib,
      ...
    }:
    with lib;
    let
      cfg = config.${namespace}.${module};
    in
    {
      options.${namespace}.${module} = with types; {
        enable = mkOption {
          description = "Manage XDG through Home-Manager.";
          default = false;
          type = bool;
        };
      };

      config.xdg = mkIf cfg.enable {
        enable = mkDefault true;
        mimeApps.enable = mkDefault true;
        autostart.enable = mkDefault true;
        # autostart.readOnly = mkDefault true;
      };
    };
}
