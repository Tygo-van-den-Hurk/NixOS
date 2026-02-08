## Defines nix settings.
{
  ...
}:
{
  imports = [ ./experimental-features ];

  nix.settings = {
    trusted-users = [ "@wheel" ];
    auto-optimise-store = true;
  };
}
