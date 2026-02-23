{
  lib,
  config,
  ...
}:
with lib;
let
  namespace = "self";
  type = "cli";
  category = "miscellaneous";
  program = "starship";
  cfg = config.${namespace}.${type}.${category}.${program};
in
{
  config.programs.${program}.settings."os" = mkIf cfg.enable {
    disabled = false;
    format = "[$symbol]($style)";
    style = "bold cyan";

    symbols = {
      AIX = "AIX";
      Alpaquita = "Alpaquita";
      AlmaLinux = "AlmaLinux";
      Alpine = "Alpine";
      Amazon = "Amazon";
      Android = "Android";
      Arch = "Arch";
      Artix = "Artix";
      Bluefin = "Bluefin";
      CachyOS = "CachyOS";
      CentOS = "CentOS";
      Debian = "Debian";
      DragonFly = "DragonFly";
      Emscripten = "Emscripten";
      EndeavourOS = "EndeavourOS";
      Fedora = "Fedora";
      FreeBSD = "FreeBSD";
      Garuda = "Garuda";
      Gentoo = "Gentoo";
      HardenedBSD = "HardenedBSD";
      Illumos = "Illumos";
      Kali = "Kali";
      Linux = "Linux";
      Mabox = "Mabox";
      Macos = "MacOS";
      Manjaro = "Manjaro";
      Mariner = "Mariner";
      MidnightBSD = "MidnightBSD";
      Mint = "Mint";
      NetBSD = "NetBSD";
      NixOS = "NixOS";
      Nobara = "Nobara";
      OpenBSD = "OpenBSD";
      OpenCloudOS = "OpenCloudOS";
      openEuler = "openEuler";
      openSUSE = "openSUSE";
      OracleLinux = "OracleLinux";
      Pop = "Pop";
      Raspbian = "Raspbian";
      Redhat = "Redhat";
      RedHatEnterprise = "RedHatEnterprise";
      RockyLinux = "RockyLinux";
      Redox = "Redox";
      Solus = "Solus";
      SUSE = "SUSE";
      Ubuntu = "Ubuntu";
      Ultramarine = "Ultramarine";
      Unknown = "Unknown";
      Uos = "Uos";
      Void = "Void";
      Windows = "Windows";
    };
  };
}
