let
  setMode = mode: {
    set_mode = mode;
  };
in
{
  inputs,
  ...
}:
let
  inherit (inputs.self.lib) find-files;
  namespace = "self";
  module = "xremap";
in
{
  flake.homeModules.${module} =
    {
      inputs,
      config,
      pkgs,
      lib,
      ...
    }:
    with lib;
    let
      cfg = config.${namespace}.${module};
    in
    {
      imports = find-files {
        base = ./.;
        exclude = ./default.nix;
        extension = ".nix";
        extra = with inputs; [
          { services.${module}.enable = mkOptionDefault false; }
          xremap.homeManagerModules.default
        ];
      };

      options.${namespace}.${module} = with types; {
        enable = mkOption {
          description = "Whether to turn on the key remapper.";
          default = false;
          type = bool;
        };
      };

      config.services.${module} = mkIf cfg.enable {
        enable = mkDefault true;
        package = mkDefault pkgs.xremap;
        config.default_mode = mkDefault "enabled";
        config.keymap = [
          {
            name = "switch modes";
            mode = "enabled";
            exact_match = true;
            remap."Ctrl-Alt-Super-Shift-Esc" = setMode "disabled";
          }
          {
            name = "switch modes";
            mode = "disabled";
            exact_match = true;
            remap."Ctrl-Alt-Super-Shift-Esc" = setMode "enabled";
          }
        ];
      };
    };
}
