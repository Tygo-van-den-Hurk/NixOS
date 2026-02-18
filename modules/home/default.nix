{ ... }:
{
  # Do not import dynamically / recursively as they use different module systems.
  imports = [
    ./cli
    # ./gui
    ./styling
  ];
}
