{
  config,
  pkgs,
  lib,
  ...
}:
with lib;
let
  namespace = "self";
  module = "secrets";
in
{
  options.${namespace}.${module} = with types; {
    raw =
      let
        secretsFile =
          pkgs.runCommand "yaml-to.json"
            {
              nativeBuildInputs = with pkgs; [ yj ];
              src = config.sops.defaultSopsFile;
            }
            /* Shell */ ''
              cat "$src" | yj > "$out"
            '';
      in
      mkOption {
        type = anything;
        description = "The secrets file raw as an expression.";
        readOnly = true;
        default = pipe secretsFile [
          builtins.readFile
          builtins.fromJSON
        ];
      };
  };
}
