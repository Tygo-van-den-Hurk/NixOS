{
  CONFIG_PATH,
  inputs,
  config,
  META,
  lib,
  ...
}:
with lib;
let
  namespace = "self";
  module = "defaults";
  submodule = "main-user";
  cfg = config.${namespace}.${module}.${submodule};
in
{

  imports = [ inputs.home-manager.nixosModules.home-manager ];

  options.${namespace}.${module}.${submodule} = with types; {
    enable = mkOption {
      description = "Whether to enable the main user (me).";
      default = config.${namespace}.${module}.enable;
      readOnly = true;
      type = bool;
    };
  };

  config.users = mkIf cfg.enable {
    mutableUsers = mkDefault false;

    users.${META.user.username} = {
      uid = mkDefault 1000;
      description = mkDefault META.user.description;
      home = mkDefault "/home/${META.user.username}";

      enable = mkDefault true;
      isNormalUser = mkDefault true;
      createHome = mkDefault true;
      linger = mkDefault true;

      hashedPasswordFile =
        mkDefault
          config.sops.secrets."hosts/${config.networking.hostName}/password".path;

      extraGroups = [
        "wheel" # sudo
        "networkmanager" # NetworkManager control
        "adm" # read system logs
        "input" # raw input devices
        "uinput" # virtual input devices
        "dialout" # serial devices (USB, Arduino, etc.)
        "video" # GPU / video devices
        "audio" # sound devices
        "camera" # webcam access (if present on your system)
        "lp" # printers
        "scanner" # scanners
      ];
    };
  };

  config.home-manager = mkIf cfg.enable {
    backupFileExtension = "backup";

    extraSpecialArgs = {
      inherit CONFIG_PATH;
      inherit inputs;
      inherit META;
    };

    users.${META.user.username} =
      { ... }:
      {
        imports = [
          inputs.self.homeModules.all
          (CONFIG_PATH + "/home.nix")
        ];
      };
  };
}
