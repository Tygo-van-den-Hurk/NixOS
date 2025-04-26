arguments @ { config, pkgs, lib, machine-settings, programs, ... } : let 

  nvidia-is-enabled = machine-settings.system.module.nvidia.enable;

in ( if ( nvidia-is-enabled == true ) then (builtins.trace "(System) Loading: ${toString ./.} (NVIDIA patches)..." {

  services.xserver.videoDrivers = [ "nvidia" ];
  programs.hyprland.enableNvidiaPatches = lib.mkDefault true;
  environment.sessionVariables.WLR_NO_HARDWARE_CURSORS = lib.mkDefault "1";

}) else {})