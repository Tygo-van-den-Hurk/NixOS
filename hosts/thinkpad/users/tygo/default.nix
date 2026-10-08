{
  home.stateVersion = "25.05";

  imports = [
    ../monitors.nix
    ../fixes.nix
  ];

  self.all.enable = true;
}
