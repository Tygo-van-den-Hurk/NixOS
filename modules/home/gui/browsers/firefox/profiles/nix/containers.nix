{
  lib,
  config,
  ...
}:
with lib;
let
  namespace = "self";
  type = "gui";
  category = "browsers";
  program = "firefox";
  profile = "nix";
  cfg = config.${namespace}.${type}.${category}.${program};
in
{
  config.programs.${program}.profiles.${profile} = mkIf cfg.enable {
    containersForce = mkDefault true;
    containers = rec {

      container-01 = {
        name = "Personal";
        color = "blue";
        icon = "circle";
        id = 1; # do not start at 0 or it will be invisible.
      };

      container-02 = {
        name = "School";
        color = "purple";
        icon = "circle";
        id = container-01.id + 1;
      };

      container-03 = {
        name = "Work";
        color = "green";
        icon = "circle";
        id = container-02.id + 1;
      };

      container-04 = {
        name = "Sketchy";
        color = "red";
        icon = "circle";
        id = container-03.id + 1;
      };

      container-05 = {
        name = "Traceable";
        color = "toolbar";
        icon = "circle";
        id = container-04.id + 1;
      };
    };
  };
}
