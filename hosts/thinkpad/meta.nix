{
  hostName = "thinkpad";
  system = "x86_64-linux";

  users = rec {
    school.groups = tygo.groups;
    tygo.groups = [
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
}
