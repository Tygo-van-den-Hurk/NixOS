## configures SOBS which is a secret management tool
arguments @ {
  config,
  pkgs,
  lib,
  machine-settings,
  input,
  ...
}: {
  imports = [
    (import input."tygo-van-den-hurk-secrets" arguments)
    input.sops-nix.nixosModules.sops
  ];

  environment.systemPackages = [pkgs.sops];
}
