{ inputs, ... }:
let
  inherit (inputs) self;

  # Read the current directory.
  curDir = ./.;
  inherit (builtins) readDir;
  files = readDir curDir;

  # Filter this directories contents on directories
  inherit (builtins) filter;
  isDirectory = file: files.${file} == "directory";
  inherit (builtins) attrNames;
  directories = filter isDirectory (attrNames files);

  # Reads `info.nix`, `configuration.nix`, and `hardware-configuration.nix` from
  # that directory and creates a home manager config and flake check from that.
  mkConfig =
    directory:
    let
      META = import "${curDir}/${directory}/meta.nix";
      CONFIG_PATH = curDir + "/${directory}";

      modules = [
        (CONFIG_PATH + "/home.nix")
        self.homeModules.all
        (
          { lib, ... }:
          with lib;
          {
            config = {
              programs.home-manager.enable = mkDefault true;
              home.username = mkDefault META.user.username;
              home.homeDirectory = mkDefault "/home/${META.user.username}";
            };
          }
        )
      ];

      extraSpecialArgs = {
        inherit CONFIG_PATH;
        inherit inputs;
        inherit META;
      };

      pkgs = import inputs.nixpkgs { inherit (META) system; };

      homeConfiguration = inputs.home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        inherit extraSpecialArgs;
        inherit modules;
      };
    in
    {
      flake.homeConfigurations."${META.user.username}@${META.hostName}" = homeConfiguration;
      # flake.checks.${system}.${hostName} = homeConfigurations.activationPackage;
    };
in
{
  # Import the just created systems and flake checks.
  imports = map mkConfig directories;
}
