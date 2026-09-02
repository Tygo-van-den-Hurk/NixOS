{ lib, ... }:
let
  name = "apply";
in
{
  perSystem = { self', ... }: {
    apps.${name} = {
      program = lib.getExe self'.packages.${name};
      inherit (self'.packages.${name}) meta;
    };
  };
}
