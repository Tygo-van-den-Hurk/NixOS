{
  lib,
  config,
  pkgs,
  ...
}:
with lib;
let
  namespace = "self";
  type = "cli";
  category = "miscellaneous";
  program = "slack-term";
  cfg = config.${namespace}.${type}.${category}.${program};
in
{
  options.${namespace}.${type}.${category}.${program} = with types; {
    enable = mkOption {
      description = "Whether to enable ${program}'s default config.";
      default = config.${namespace}.${type}.${category}.enable;
      type = bool;
    };

    settings = mkOption {
      description = "Settings for ${program}, written as JSON.";
      default = { };
      type = attrs;
    };

    package = mkOption {
      description = "The package to use for ${program}.";
      default = pkgs.writeShellScriptBin "${program}-wrapped" ''
        set -e

        if [ -n "$XDG_CONFIG_HOME" ]; then
          CONFIG="$XDG_CONFIG_HOME/${program}/config.json"
          TOKEN_FILE="$XDG_CONFIG_HOME/${program}/token"
        else
          CONFIG="$HOME/.config/${program}/config.json"
          TOKEN_FILE="$HOME/.config/${program}/token"
        fi

        if [ -f "$TOKEN_FILE" ]; then
          TOKEN=$(<"$TOKEN_FILE")
        else
          TOKEN=""
        fi

        args=()
        has_token=false
        has_config=false
        has_debug=false

        for arg in "$@"; do
          [[ "$arg" == "-token" ]] && has_token=true
          [[ "$arg" == "-config" ]] && has_config=true
          [[ "$arg" == "-debug" ]] && has_debug=true
          args+=("$arg")
        done

        if ! $has_config; then
          args+=("-config" "$CONFIG")
        fi

        if ! $has_token; then
          args+=("-token" "$TOKEN")
          if $has_debug; then
            echo "$(date +"%Y/%m/%d %H:%M:%S") no token provided as argument, using one from disk at: $TOKEN_FILE"
          fi
        fi

        exec ${getExe pkgs.${program}} "''${args[@]}"
      '';
    };
  };

  config.xdg.configFile = mkIf cfg.enable {
    "${program}/config.json".text =
      let
        base16Scheme = if config ? stylix then config.stylix.base16Scheme else { };
      in
      builtins.toJSON (mkMerge [
        {
          sidebar_width = 1;
          notify = "mention";
          emoji = false;

          # command
          key_map.command."i" = "mode-insert";
          key_map.command."/" = "mode-search";
          key_map.command."k" = "channel-up";
          key_map.command."j" = "channel-down";
          key_map.command."g" = "channel-top";
          key_map.command."G" = "channel-bottom";
          key_map.command."K" = "thread-up";
          key_map.command."J" = "thread-down";
          key_map.command."<previous>" = "chat-up";
          key_map.command."C-b" = "chat-up";
          key_map.command."C-u" = "chat-up";
          key_map.command."<next>" = "chat-down";
          key_map.command."C-f" = "chat-down";
          key_map.command."C-d" = "chat-down";
          key_map.command."n" = "channel-search-next";
          key_map.command."N" = "channel-search-previous";
          key_map.command."'" = "channel-jump";
          key_map.command."q" = "quit";
          key_map.command."<f1>" = "help";

          # insert
          key_map.insert."<left>" = "cursor-left";
          key_map.insert."<right>" = "cursor-right";
          key_map.insert."<enter>" = "send";
          key_map.insert."<escape>" = "mode-command";
          key_map.insert."<backspace>" = "backspace";
          key_map.insert."C-8" = "backspace";
          key_map.insert."<delete>" = "delete";
          key_map.insert."<space>" = "space";

          # search
          key_map.search."<left>" = "cursor-left";
          key_map.search."<right>" = "cursor-right";
          key_map.search."<escape>" = "clear-input";
          key_map.search."<enter>" = "clear-input";
          key_map.search."<backspace>" = "backspace";
          key_map.search."C-8" = "backspace";
          key_map.search."<delete>" = "delete";
          key_map.search."<space>" = "space";

          # theme view
          theme.view.fg = base16Scheme.base05 or "white";
          theme.view.bg = base16Scheme.base00 or "default";
          theme.view.border_fg = base16Scheme.base0D or "white";
          theme.view.border_bg = base16Scheme.base03 or null;
          theme.view.label_fg = base16Scheme.base05 or "white";
          theme.view.label_bg = base16Scheme.base01 or null;

          # theme channel
          theme.channel.prefix = "";
          theme.channel.icon = "";
          theme.channel.text = "";

          # theme message
          theme.message.time_format = "15=04";
          theme.message.name = "colorize";
          theme.message.time = "";
          theme.message.text = "";
        }
        cfg.settings
      ]);
  };

  config.home = mkIf cfg.enable {
    packages = [ cfg.package ];
    shellAliases = rec {
      ${program} = slack;
      slack = getExe cfg.package;
    };
  };
}
