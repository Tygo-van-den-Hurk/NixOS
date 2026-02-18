{
  CONFIG_PATH,
  inputs,
  hostName,
  system,
  config,
  lib,
  ...
}:
with lib;
let
  module = "defaults";
  submodule = "main-user";
  cfg = config.${module}.${submodule};
in
{

  imports = [ inputs.home-manager.nixosModules.home-manager ];

  options.${module}.${submodule} = with types; {
    enable = mkOption {
      description = "Whether to enable the main user (me).";
      default = config.${module}.enable;
      readOnly = true;
      type = bool;
    };

    username = mkOption {
      description = "The username of the main user (me).";
      default = "tygo";
      readOnly = true;
      type = str;
    };

    description = mkOption {
      description = "The description of the main user (me).";
      default = "Tygo van den Hurk";
      readOnly = true;
      type = str;
    };
  };

  config.users.mutableUsers = mkDefault false;

  config.users.users.${cfg.username} = mkIf cfg.enable {
    uid = mkDefault 1000;
    description = mkDefault cfg.description;
    home = mkDefault "/home/${cfg.username}";

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

    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHvSu8xkYJQX2br3EHxNADY7byEzRAXlc+Z8X+vbwuRd tygo@thinkpad"
    ];
  };

  config.home-manager = mkIf cfg.enable {
    extraSpecialArgs = {
      inherit CONFIG_PATH;
      inherit inputs;
      inherit hostName;
      inherit system;
    };

    users.${cfg.username} =
      { ... }:
      {
        imports = [
          inputs.self.homeModules.cli
          inputs.self.homeModules.gui
          inputs.self.homeModules.styling
          (CONFIG_PATH + "/home.nix")
        ];
      };
  };
}
