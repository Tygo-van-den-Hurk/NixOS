{
  config,
  lib,
  ...
}:
let
  inherit (lib) mkDefault;
  inherit (lib) mkOption;
  inherit (lib) mkIf;
  inherit (lib) types;

  inherit (types) bool;
  inherit (types) str;

  module = "defaults";
  submodule = "main-user";

  name = config.${module}.${submodule}.username;
in
{
  options.${module}.${submodule} = {
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

  config.users.users.${name} = mkIf config.${module}.${submodule}.enable {
    uid = mkDefault 1000;
    description = mkDefault config.${module}.${submodule}.description;
    home = mkDefault "/home/${name}";

    enable = mkDefault true;
    isNormalUser = mkDefault true;
    createHome = mkDefault true;
    linger = mkDefault true;

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
}
