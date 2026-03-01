{ inputs, ... }:
{
  # Do not import dynamically / recursively as they use different module systems.
  imports = [
    inputs.home-manager.flakeModules.home-manager
    ./all
    ./cli
    ./gui
    ./styling
    ./wm
    ./xremap
  ];
}
