{ lib, ... }:
with lib;
{
  # Emulate the real SOPS secrets.
  sops = {
    defaultSopsFile = mkForce ./fake.yaml;
    defaultSopsFormat = mkForce "yaml";
    age.keyFile = mkForce "./age.key";
  };
}
