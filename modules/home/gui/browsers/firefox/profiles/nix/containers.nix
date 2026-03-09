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

      Personal = {
        color = "blue";
        icon = "circle";
        id = 0;
      };

      School = {
        color = "purple";
        icon = "circle";
        id = Personal.id + 1;
      };

      Work = {
        color = "green";
        icon = "circle";
        id = School.id + 1;
      };

      Sketchy = {
        color = "red";
        icon = "circle";
        id = Work.id + 1;
      };

      Traceable = {
        color = "toolbar";
        icon = "circle";
        id = Sketchy.id + 1;
      };
    };
  };
}
