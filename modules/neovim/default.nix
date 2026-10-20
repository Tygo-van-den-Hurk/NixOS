{
  lib,
  ...
}:
with lib;
{
  options.flake = with types; {
    neovimModules = mkOption {
      description = "Modules used to configure neovim.";
      type = lazyAttrsOf deferredModule;
      default = { };
    };
  };

  imports = [
    ./all
    ./languages
    ./plugins
    ./shortcuts
  ];
}
