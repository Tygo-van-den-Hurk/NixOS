{ inputs, ... }:
let
  inherit (inputs.nixpkgs) lib;
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
  # that directory and creates a NixOS system and flake check from that.
  mkSystem =
    directory:
    let
      META = import "${curDir}/${directory}/meta.nix";
      CONFIG_PATH = curDir + "/${directory}";

      modules = [
        (CONFIG_PATH + "/configuration.nix")
        self.nixosModules.all
      ];

      specialArgs = {
        inherit CONFIG_PATH;
        inherit inputs;
        inherit META;
      };

      nixosSystem = lib.nixosSystem {
        inherit (META) system;
        inherit specialArgs;
        inherit modules;
      };
    in
    {
      flake.nixosConfigurations.${META.hostName} = nixosSystem;
      flake.checks.${META.system}.${META.hostName} = nixosSystem.config.system.build.toplevel;
    };
in
{
  # Import the just created systems and flake checks.
  imports = map mkSystem directories;
}
