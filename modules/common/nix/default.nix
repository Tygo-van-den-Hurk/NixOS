## Defines nix settings.
{
  ...
}:
{
  imports = [
    ./settings
    ./gc
  ];

  nix = {
    channel.enable = false;
  };
}
