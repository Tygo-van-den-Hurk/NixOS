{
  lib,
  config,
  ...
}:
with lib;
let
  namespace = "self";
  type = "gui";
  category = "editors";
  program = "vscode";
  cfg = config.${namespace}.${type}.${category}.${program};
in
{
  config.xdg.mimeApps = mkIf cfg.mkDefault rec {
    associations.added = defaultApplications;
    defaultApplications = {

      # Core text
      "text/plain" = [ "${cfg.packageName}.desktop" ];
      "text/markdown" = [ "${cfg.packageName}.desktop" ];
      "text/x-readme" = [ "${cfg.packageName}.desktop" ];
      "text/richtext" = [ "${cfg.packageName}.desktop" ];

      # Config formats
      "text/x-ini" = [ "${cfg.packageName}.desktop" ];
      "text/x-toml" = [ "${cfg.packageName}.desktop" ];
      "application/x-yaml" = [ "${cfg.packageName}.desktop" ];
      "text/yaml" = [ "${cfg.packageName}.desktop" ];
      "application/json" = [ "${cfg.packageName}.desktop" ];
      "application/ld+json" = [ "${cfg.packageName}.desktop" ];
      "application/xml" = [ "${cfg.packageName}.desktop" ];
      "text/xml" = [ "${cfg.packageName}.desktop" ];

      # Web
      "text/html" = [ "${cfg.packageName}.desktop" ];
      "application/xhtml+xml" = [ "${cfg.packageName}.desktop" ];
      "text/css" = [ "${cfg.packageName}.desktop" ];
      "text/javascript" = [ "${cfg.packageName}.desktop" ];
      "application/javascript" = [ "${cfg.packageName}.desktop" ];
      "application/x-httpd-php" = [ "${cfg.packageName}.desktop" ];

      # Shell
      "application/x-shellscript" = [ "${cfg.packageName}.desktop" ];
      "text/x-shellscript" = [ "${cfg.packageName}.desktop" ];
      "text/x-zsh" = [ "${cfg.packageName}.desktop" ];

      # C / C++
      "text/x-c" = [ "${cfg.packageName}.desktop" ];
      "text/x-csrc" = [ "${cfg.packageName}.desktop" ];
      "text/x-chdr" = [ "${cfg.packageName}.desktop" ];
      "text/x-c++src" = [ "${cfg.packageName}.desktop" ];
      "text/x-c++hdr" = [ "${cfg.packageName}.desktop" ];

      # Java / JVM
      "text/x-java" = [ "${cfg.packageName}.desktop" ];
      "application/x-java" = [ "${cfg.packageName}.desktop" ];
      "application/x-groovy" = [ "${cfg.packageName}.desktop" ];
      "text/x-kotlin" = [ "${cfg.packageName}.desktop" ];
      "text/x-scala" = [ "${cfg.packageName}.desktop" ];

      # Python
      "text/x-python" = [ "${cfg.packageName}.desktop" ];
      "application/x-python-code" = [ "${cfg.packageName}.desktop" ];

      # Systems / Modern
      "text/x-rust" = [ "${cfg.packageName}.desktop" ];
      "text/x-go" = [ "${cfg.packageName}.desktop" ];
      "text/x-swift" = [ "${cfg.packageName}.desktop" ];
      "text/x-zig" = [ "${cfg.packageName}.desktop" ];
      "text/x-nix" = [ "${cfg.packageName}.desktop" ];

      # Functional
      "text/x-haskell" = [ "${cfg.packageName}.desktop" ];
      "text/x-ocaml" = [ "${cfg.packageName}.desktop" ];
      "text/x-elixir" = [ "${cfg.packageName}.desktop" ];
      "text/x-clojure" = [ "${cfg.packageName}.desktop" ];

      # Data / Query
      "application/sql" = [ "${cfg.packageName}.desktop" ];
      "text/x-sql" = [ "${cfg.packageName}.desktop" ];
      "text/csv" = [ "${cfg.packageName}.desktop" ];
      "application/csv" = [ "${cfg.packageName}.desktop" ];

      # DevOps
      "application/x-dockerfile" = [ "${cfg.packageName}.desktop" ];
      "text/x-dockerfile" = [ "${cfg.packageName}.desktop" ];
      "application/x-sh" = [ "${cfg.packageName}.desktop" ];

      # Misc common
      "application/x-subrip" = [ "${cfg.packageName}.desktop" ];
      "text/x-log" = [ "${cfg.packageName}.desktop" ];
      "text/x-patch" = [ "${cfg.packageName}.desktop" ];
      "text/x-diff" = [ "${cfg.packageName}.desktop" ];
    };
  };
}
