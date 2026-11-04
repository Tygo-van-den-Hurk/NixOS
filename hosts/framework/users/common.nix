{
  options,
  config,
  pkgs,
  lib,
  ...
}:
with lib;
{
  config = mkMerge [

    # Configure stylix theme iff stylix is available to match laptop colors.
    (optionalAttrs (options.stylix or { } ? polarity) {
      stylix = mkIf (config.stylix.polarity or null == "dark") {
        base16Scheme = mkForce "${pkgs.base16-schemes}/share/themes/0x96f.yaml";
      };
    })
  ];
}
