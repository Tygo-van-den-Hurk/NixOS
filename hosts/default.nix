let
  get-sub-directories = import ./get-sub-directories.nix;
in
{
  inputs,
  ...
}:
let
  inherit (inputs.nixpkgs) lib;
  inherit (inputs) self;

  curDir = ./.;

  # Reads `info.nix`, `configuration.nix`, and `hardware-configuration.nix` from
  # that directory and creates a NixOS system and flake check from that.
  mkSystem =
    directory:
    let
      META = import "${curDir}/${directory}/meta.nix";
      CONFIG_PATH = curDir + "/${directory}";

      inherit (META) hostName;
      inherit (META) system;

      modules = [
        { networking.hostName = lib.mkDefault hostName; }
        (CONFIG_PATH + "/config")
        self.nixosModules.all
        ./users.nix
      ];

      specialArgs = {
        inherit system;
        inherit CONFIG_PATH;
        inherit inputs;
        inherit META;
      };

      nixosSystem = lib.nixosSystem {
        inherit system;
        inherit specialArgs;
        inherit modules;
      };
    in
    {
      flake.nixosConfigurations.${hostName} = nixosSystem;
      flake.checks.${system}.${hostName} = nixosSystem.config.system.build.toplevel;
      self.ci.configurations.nixos.".auto--nixos--${hostName}.nix" = {
        hostname = hostName;
        inherit system;
      };
    };

  hosts = get-sub-directories curDir;
in
{
  # Import the just created systems and flake checks.
  imports = map mkSystem hosts;
}
