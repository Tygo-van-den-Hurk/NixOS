{
  input,
  root-directory-repository,
  system,
  ...
}:
# #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
let

  lib = builtins.trace "(System) Loading: Library from Nix Packages..." input.nixpkgs.lib;

  recursiveMerge = import ./recursive-merge.nix { inherit lib; };
  nixosConfigurationsFilePaths = import ./list.nix;

  PathToSystem =
    pathToConfig:
    #| import all levels of settings
    let
      __settings_ = {
        global = import (pathToConfig + "/../../common-settings.nix");
        category = import (pathToConfig + "/../common-settings.nix");
        machine = import (pathToConfig + "/settings.nix");
      };

      settings = {
        inherit (__settings_) global;

        inherit (__settings_) category;
        inherit (__settings_) machine;
      };

      __machine-settings__ = recursiveMerge (
        with settings;
        [
          global
          category
          machine
        ]
      );

      machine-settings = __machine-settings__ // {
        inherit pathToConfig;
      };

      blueprint = {
        system = machine-settings.system.architecture;
        specialArgs = {
          inherit input;
          inherit system;
          inherit machine-settings;
          inherit root-directory-repository;
        };

        modules = [
          (machine-settings.pathToConfig + "/overrides.nix")
          (machine-settings.pathToConfig + "/hardware-configuration.nix")
          ../modules

          #` Custom input modules
          input.nur.modules.nixos.default # Adding the NixOS User Repository
          input.nix-index-database.nixosModules.nix-index
        ];
      };

      nixosSystem = lib.nixosSystem blueprint;

      result =
        let
          name = machine-settings.system.hostname;
          value = nixosSystem;
        in
        lib.nameValuePair name value;
    in
    #| return:
    result;

  PathsToSystems =
    paths:
    #| Creating all the systems out of the paths
    let
      # Set:{ name, value } <-- map( function, list )
      setOfSystems = builtins.map PathToSystem paths;

      # Set <-- List( Set:{ name, value } )
      result = builtins.listToAttrs setOfSystems;
    in
    #| return:
    result;
in
# PathsToSystems
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~-~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
PathsToSystems nixosConfigurationsFilePaths
