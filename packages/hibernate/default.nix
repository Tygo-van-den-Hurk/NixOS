let
  name = "hibernate";
in
{
  perSystem =
    {
      pkgs,
      lib,
      ...
    }:
    with pkgs;
    with lib;
    rec {
      packages.${name} = writeShellApplication {
        inherit name;
        text = builtins.readFile ./script.bash;
        meta = {
          description = "Lock AND THEN hibernate your device.";
          license = with licenses; epl20;
          maintainers = with maintainers; [
            Tygo-van-den-Hurk
          ];
        };
      };

      checks.${name} = packages.${name};
    };
}
