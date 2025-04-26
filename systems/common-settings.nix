## This file contains all the settings that will be used in configuration.nix
#! Changing this will change this setting - unless overwritten - for all machines.
{
  users = {
    tygo = {
      # TODO : split settings to 'home-manager', and 'nixos'
      initialPassword = "changeme"; #! Defines user accounts with a weak password.
      isNormalUser = true; # wether or not you're a human user
      description = "Tygo van den Hurk"; # Your full name
      uid = 1000;

      extraGroups = [
        "networkmanager" # used for configuring the network
        "wheel"
        "adm"
        "admin " # used for sudo
        "input" # used for xmonad
        "uinput" # used for xmonad
        "video" #? unknown
        "audio" #? unknown
        "camera" #? unknown
        "lp" #? unknown
        "scanner" #? unknown
      ];

      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHvSu8xkYJQX2br3EHxNADY7byEzRAXlc+Z8X+vbwuRd tygo@tygos-thinkpad-nixos-25-06-2024"
      ];

      init = {
        modules = {
          docker.enable = true;
          home-manager = {
            enable = true;
            configPath = "tygo-van-den-hurk-dotfiles";
          };
          virtualbox.enable = false;
        };

        defaultApps = {
          # Sets the default apps to use
          terminal = "alacritty"; # The default Termial app to load when opening a terminal.
          editor = "code"; # The default Editor to load when editing a file.
          browser = "firefox"; # The default browser open pages with.
        };
      };
    };
  };

  modules = {
    key-remapper = "xremap"; # wether or not to load the 'xremap' module.
  };

  system = {
    type = null; # The type of the system, example is "laptop".
    hostname = null; # The hostname of the computer in lower caps.
    architecture = null; # The architecture the system uses.

    packages = {
      allowUnfree = null; # Wether or not to allow unfree packages.
    };

    modules = {
      gpg.enable = false;
      local-ai.enable = false;
      podman.enable = false;
      power-efficiency.enable = false;
      openssh.enable = false;
      wsl.enable = false;
      via.enable = false;
      nvidia.enable = false;
      gaming.enable = false;
      onedrive.enable = false;
      gui = {
        hyprland .enable = false;
        gnome    .enable = false;
        kde      .enable = false;
        i3wm     .enable = false;
      };
    };
  };
}
