{
  config,
  lib,
  ...
}:
with lib;
let
  namespace = "self";
  module = "secrets";
  submodule = "nas";
  cfg = config.${namespace}.${module};
in
{
  options.${namespace}.${module}.${submodule} = with types; {
    credentials = mkOption {
      description = "Path to the NAS credentials.";
      default = config.sops.secrets."nas/credentials".path or null;
      readOnly = true;
      type = anything;
    };
  };

  config.sops.secrets = mkIf cfg.enable {
    "nas/credentials" = mkDefault { };
  };
}
