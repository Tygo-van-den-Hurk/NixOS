{
  lib,
  config,
  ...
}:
with lib;
let
  type = "gui";
  category = "browsers";
  program = "firefox";
  profile = "main";
  cfg = config.${type}.${category}.${program};
in
{
  config.programs.${program}.profiles.${profile}.containers = mkIf cfg.enable rec {
    containersForce = mkDefault true;

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
      color = "white";
      icon = "circle";
      id = sketchy.id + 1;
    };
  };
}
