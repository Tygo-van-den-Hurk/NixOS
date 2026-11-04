{
  home.stateVersion = "26.05";
  self.all.enable = true;
  imports = [
    ../monitors.nix
    ../common.nix
    ../fixes.nix
  ];
}
