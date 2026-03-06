{
  config,
  pkgs,
  lib,
  ...
}:
with lib;
let
  namespace = "self";
  type = "wm";
  program = "waybar";
  cfg = config.${namespace}.${type}.${program};
in
{
  config.programs.${program}.settings = mkIf cfg.enable {
    mainBar."custom/power-button" = {
      format = "<span size='large'>󰐥</span>";

      tooltip = true;
      tooltip-format = strings.trim ''
        Access power states of the system.
      '';

      on-click = getExe (
        pkgs.writeShellScriptBin "${program}-power-button-on-click" ''
          exec > >(systemd-cat -t '${program}-power-button-on-click') 2>&1
          ${getExe pkgs.wlogout}
        ''
      );
    };
  };

  config.programs.wlogout = mkIf cfg.enable {
    enable = mkDefault true;

    layout = [
      {
        text = "Lock";
        label = "lock";
        action = "${getExe config.programs.hyprlock.package}";
      }
      {
        text = "Logout";
        label = "logout";
        action = getExe (
          pkgs.writeShellScriptBin "${program}-wlogout-hibernate" ''
            exec > >(systemd-cat -t '${program}-wlogout-hibernate') 2>&1
            ${getExe config.programs.hyprlock.package} &
            hyprctl dispatch exit
          ''
        );
      }
      {
        text = "Suspend";
        label = "suspend";
        action = "systemctl suspend";
      }
      {
        text = "Hibernate";
        label = "hibernate";
        action = getExe (
          pkgs.writeShellScriptBin "${program}-wlogout-hibernate" ''
            exec > >(systemd-cat -t '${program}-wlogout-hibernate') 2>&1
            ${getExe pkgs.hyprlock} &
            systemctl hibernate
          ''
        );
      }
      {
        text = "Shutdown";
        label = "shutdown";
        action = "shutdown -h now";
      }
      {
        text = "Reboot";
        label = "reboot";
        action = "reboot";
      }
    ];

    style = /* CSS */ ''
      * {
        font-family: "${config.stylix.fonts."monospace".name}";
        font-size: ${builtins.toString config.stylix.fonts.sizes.desktop}pt;
      }

      window {
        background: alpha(#${config.stylix.base16Scheme.base00}, 0.8);
      }

      button {
        background: #${config.stylix.base16Scheme.base01};
        text-decoration-color: #${config.stylix.base16Scheme.base05};
        color: #${config.stylix.base16Scheme.base05};
        border-style: solid;
        border-width: 1px;
        background-repeat: no-repeat;
        background-position: center;
        background-size: 25%;
        border-radius: 0;
        margin: 5px;
      }

      button:focus, button:active, button:hover {
        border-color: #${config.stylix.base16Scheme.base0D};
        outline-style: none;
      }

      #lock {
        background-image: image(
          url("${config.programs.wlogout.package}/share/wlogout/icons/lock.png")
        );
      }

      #logout {
        background-image: image(
          url("${config.programs.wlogout.package}/share/wlogout/icons/logout.png")
        );
      }

      #suspend {
        background-image: image(
          url("${config.programs.wlogout.package}/share/wlogout/icons/suspend.png")
        );
      }

      #hibernate {
        background-image: image(
          url("${config.programs.wlogout.package}/share/wlogout/icons/hibernate.png")
        );
      }

      #shutdown {
        background-image: image(
          url("${config.programs.wlogout.package}/share/wlogout/icons/shutdown.png")
        );
      }

      #reboot {
        background-image: image(
          url("${config.programs.wlogout.package}/share/wlogout/icons/reboot.png")
        );
      }
    '';
  };
}
