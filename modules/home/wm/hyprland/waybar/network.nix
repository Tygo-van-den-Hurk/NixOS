{
  lib,
  config,
  pkgs,
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
  config.programs.${program}.settings = mkIf cfg.enable rec {

    mainBar."network#wifi" = {
      rotate = 0;
      interval = 2;
      interface = "wlp0s20f3";

      format-wifi = "<span size='x-large'>{icon}</span>";
      format-linked = "<span size='x-large'>󰤫</span>";
      format-disconnected = "<span size='x-large'>󰤯</span>";
      format-disabled = "<span size='x-large'>󰤭</span>";
      format-icons = [
        "󰤟"
        "󰤢"
        "󰤥"
        "󰤨"
      ];

      tooltip = true;
      tooltip-format-disconnected = "Disconnected";
      tooltip-format = strings.trim ''
        <b>Interface</b>: {ifname}
        <b>Network</b>: {essid}
        <b>Signal strength</b>: {signaldBm}dBm ({signalStrength}%)
        <b>Frequency</b>: {frequency}MHz
      '';

      on-click = getExe (
        pkgs.writeShellScriptBin "${program}-network-wifi-on-click" ''
          exec > >(systemd-cat -t '${program}-network-wifi-on-click') 2>&1
          ${getExe pkgs.nmgui}
        ''
      );

      on-click-right = getExe (
        pkgs.writeShellScriptBin "${program}-network-wifi-on-right-click" ''
          exec > >(systemd-cat -t '${program}-1') 2>&1
          status="$(${pkgs.networkmanager}/bin/nmcli radio wifi)"
          if echo "$status" | grep -q enabled; then
            ${pkgs.networkmanager}/bin/nmcli radio wifi off
          else # Wifi is not enabled.
            ${pkgs.networkmanager}/bin/nmcli radio wifi on
          fi
        ''
      );
    };

    mainBar."custom/tailscale" =
      let
        script = pkgs.writeShellScriptBin "${program}-tailscale-script" ''
          base00="#${config.stylix.base16Scheme.base00}"
          base01="#${config.stylix.base16Scheme.base01}"
          base02="#${config.stylix.base16Scheme.base02}"
          base03="#${config.stylix.base16Scheme.base03}"
          base04="#${config.stylix.base16Scheme.base04}"
          base05="#${config.stylix.base16Scheme.base05}"
          base06="#${config.stylix.base16Scheme.base06}"
          base07="#${config.stylix.base16Scheme.base07}"
          base08="#${config.stylix.base16Scheme.base08}"
          base09="#${config.stylix.base16Scheme.base09}"
          base0A="#${config.stylix.base16Scheme.base0A}"
          base0B="#${config.stylix.base16Scheme.base0B}"
          base0C="#${config.stylix.base16Scheme.base0C}"
          base0D="#${config.stylix.base16Scheme.base0D}"
          base0E="#${config.stylix.base16Scheme.base0E}"
          base0F="#${config.stylix.base16Scheme.base0F}"

          PATH="${
            makeBinPath (
              with pkgs;
              [
                busybox
                jq
                tailscale
              ]
            )
          }"

          ${builtins.readFile ./tailscale.sh}
        '';
      in
      {
        exec = "${getExe script} --status";
        exec-on-event = true;
        interval = 5;
        return-type = "json";

        format = "<span size='x-large'>{icon}</span>";
        format-icons = {
          connected = "";
          stopped = "";
          connecting = "";
          disconnecting = "";
        };

        tooltip = true;

        on-click-right = "${getExe script} --toggle";
        on-click = getExe (
          pkgs.writeShellScriptBin "${program}-network-wifi-on-click" ''
            exec > >(systemd-cat -t '${program}-network-wifi-on-click') 2>&1
            ${pkgs.xdg-utils}/bin/xdg-open "https://login.tailscale.com"
          ''
        );
      };
  };
}
