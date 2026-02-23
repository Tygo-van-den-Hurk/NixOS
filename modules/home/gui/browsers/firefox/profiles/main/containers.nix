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
  profile = "main";
  cfg = config.${namespace}.${type}.${category}.${program};
in
{
  config.programs.${program}.profiles.${profile} = mkIf cfg.enable {
    containersForce = mkDefault true;
    containers = rec {

      personal = {
        name = "Personal";
        color = "purple";
        icon = "circle";
        id = 0;
      };

      school = {
        name = "School";
        color = "purple";
        icon = "circle";
        id = personal.id + 1;
      };

      work = {
        name = "Work";
        color = "green";
        icon = "circle";
        id = school.id + 1;
      };

      sketchy = {
        name = "Sketchy";
        color = "red";
        icon = "circle";
        id = work.id + 1;
      };

      traceable = {
        name = "Traceable";
        color = "toolbar";
        icon = "circle";
        id = sketchy.id + 1;
      };
    };
  };
}
