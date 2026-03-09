{
  lib,
  config,
  pkgs,
  ...
}:
with lib;
let
  namespace = "self";
  type = "gui";
  category = "browsers";
  program = "firefox";
  profile = "nix";
  cfg = config.${namespace}.${type}.${category}.${program};
in
{
  config.programs.${program}.profiles.${profile}.extensions = mkIf cfg.enable {
    force = mkDefault true;

    packages = with pkgs.firefoxAddons; [
      sponsorblock
      darkreader
      ublock-origin # uBlock origin 
      decentraleyes # Decentraleyes
      privacy-badger17 # Privacy Badger
      # youtube-recommended-videos # Unhook: Remove YouTube Recommended Videos Comments  
      bitwarden-password-manager # Bitwarden
      tomato-clock # Tomato Clock - A Simple Pomodoro Timer
      chrome-mask # Chrome Mask - Makes Firefox wear a mask to look like Chrome to websites that block Firefox otherwise.
      clearurls # ClearURLs - Removes tracking elements from URLs
    ];

    settings = {
      # <name>.force	Forcibly override any existing configuration for this extension. 	boolean
      # <name>.settings	Json formatted options for the specified extensionID	attribute set of (JSON value)

      # uBlock origin 
      "uBlock0@raymondhill.net" = {
        force = true;
        settings = {
          selectedFilterLists = [
            "ublock-filters"
            "ublock-badware"
            "ublock-privacy"
            "ublock-unbreak"
            "ublock-quick-fixes"
          ];
        };
      };

      # Decentraleyes
      "jid1-BoFifL9Vbdl2zQ@jetpack" = {
        force = true;
        settings = { };
      };

      # Privacy Badger
      "jid1-MnnxcxisBPnSXQ@jetpack" = {
        force = true;
        settings = { };
      };

      # Unhook: Remove YouTube Recommended Videos Comments  
      "myallychou@gmail.com" = {
        force = true;
        settings = { };
      };

      # Bitwarden
      "{446900e4-71c2-419f-a6a7-df9c091e268b}" = {
        force = false; # FALSE!!!!
        settings = { };
      };

      # Tomato Clock - A Simple Pomodoro Timer
      "jid1-Kt2kYYgi32zPuw@jetpack" = {
        force = true;
        settings = { };
      };

      # Chrome Mask - Makes Firefox wear a mask to look like Chrome to websites that block Firefox otherwise.
      "chrome-mask@overengineer.dev" = {
        force = true;
        settings = { };
      };

      # ClearURLs - Removes tracking elements from URLs
      "{74145f27-f039-47ce-a470-a662b129930a}" = {
        force = true;
        settings = { };
      };
    };
  };
}
