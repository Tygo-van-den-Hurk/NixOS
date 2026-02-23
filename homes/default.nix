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
      info = import "${curDir}/${directory}/info.nix";
      inherit (info) hostName;
      inherit (info) system;
      inherit (info) username;

      CONFIG_PATH = curDir + "/${directory}";

      modules = [
        {
          programs.home-manager.enable = true;
        }
        (CONFIG_PATH + "/home.nix")
        self.homeModules.all
      ];

      extraSpecialArgs = {
        inherit CONFIG_PATH;
        inherit hostName;
        inherit username;
        inherit inputs;
        inherit system;
      };

      pkgs = import inputs.nixpkgs { inherit system; };

      homeConfiguration = inputs.home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        inherit extraSpecialArgs;
        inherit modules;
      };
    in
    {
      flake.homeConfigurations."${username}@${hostName}" = homeConfiguration;
      # flake.checks.${system}.${hostName} = homeConfigurations.activationPackage;
    };
in
{
  # Import the just created systems and flake checks.
  imports = map mkConfig directories;
}
