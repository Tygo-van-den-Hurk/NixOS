## configures SOBS which is a secret management tool
arguments@{
  pkgs,
  input,
  ...
}:
{
  imports = [
    (import input."tygo-van-den-hurk-secrets" arguments)
    input.sops-nix.nixosModules.sops
  ];

  environment.systemPackages = [ pkgs.sops ];
}
