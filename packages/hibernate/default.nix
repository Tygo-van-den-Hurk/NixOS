let
  name = "hibernate";
in
{
  self.ci.packages.".auto--package--${name}.nix" = {
    inherit name;
    systems = [ "x86_64-linux" ];
  };

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
