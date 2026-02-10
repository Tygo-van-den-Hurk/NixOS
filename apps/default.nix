{ ... }:
{
  imports = [
    ./apply
  ];

  perSystem = { self', ... }: {
    apps.default = self'.apps.apply;
  };
}
