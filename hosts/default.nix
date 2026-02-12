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
      info = import "${curDir}/${directory}/info.nix";
      inherit (info) hostName;
      inherit (info) system;

      modules = [
        "${curDir}/${directory}/configuration.nix"
        "${curDir}/${directory}/hardware-configuration.nix"
        self.nixosModules.defaults
        self.nixosModules.nas
      ];

      specialArgs = {
        inherit hostName;
        inherit inputs;
        inherit system;
      };

      nixosSystem = lib.nixosSystem {
        inherit specialArgs;
        inherit modules;
        inherit system;
      };
    in
    {
      flake.nixosConfigurations.${hostName} = nixosSystem;
      flake.checks.${system}.${hostName} = nixosSystem.config.system.build.toplevel;
    };
in
{
  # Import the just created systems and flake checks.
  imports = map mkSystem directories;
}
