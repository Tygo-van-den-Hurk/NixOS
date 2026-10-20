let
  boilerplate = import ./boilerplate.nix;
in
{
  inputs,
  ...
}:
let
  inherit (inputs) self;
  inherit (inputs) home-manager;
  extraSpecialArgs = {
    inherit inputs;
  };
in
{
  perSystem =
    {
      pkgs,
      ...
    }:
    let
      home = home-manager.lib.homeManagerConfiguration {
        inherit extraSpecialArgs;
        inherit pkgs;
        modules = with self; [
          homeModules.all
          boilerplate
        ];
      };
    in
    {
      packages."neovim" = home.config.self.cli.editors.neovim.finalPackage;
    };
}
