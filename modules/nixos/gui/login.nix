{
  config,
  pkgs,
  META,
  lib,
  ...
}:
with lib;
let
  namespace = "self";
  module = "gui";
  program = "sddm";
  cfg = config.${namespace}.${module}.${program};

  theme = with pkgs; rec {
    name = "personalised-sddm-theme";
    package = stdenv.mkDerivation rec {
      inherit name;

      src = sddm-astronaut;
      inherit (sddm-astronaut) dontWrapQtApps;
      inherit (sddm-astronaut) propagatedBuildInputs;

      inherit (config.networking) hostName;

      inherit (config.home-manager.users.${META.user.username}.stylix) image;

      fontName = config.home-manager.users.${META.user.username}.stylix.fonts.sansSerif.name;

      inherit (config.home-manager.users.${META.user.username}.stylix.base16Scheme) base00;
      inherit (config.home-manager.users.${META.user.username}.stylix.base16Scheme) base01;
      inherit (config.home-manager.users.${META.user.username}.stylix.base16Scheme) base02;
      inherit (config.home-manager.users.${META.user.username}.stylix.base16Scheme) base03;
      inherit (config.home-manager.users.${META.user.username}.stylix.base16Scheme) base04;
      inherit (config.home-manager.users.${META.user.username}.stylix.base16Scheme) base05;
      inherit (config.home-manager.users.${META.user.username}.stylix.base16Scheme) base06;
      inherit (config.home-manager.users.${META.user.username}.stylix.base16Scheme) base07;
      inherit (config.home-manager.users.${META.user.username}.stylix.base16Scheme) base08;
      inherit (config.home-manager.users.${META.user.username}.stylix.base16Scheme) base09;
      inherit (config.home-manager.users.${META.user.username}.stylix.base16Scheme) base0A;
      inherit (config.home-manager.users.${META.user.username}.stylix.base16Scheme) base0B;
      inherit (config.home-manager.users.${META.user.username}.stylix.base16Scheme) base0C;
      inherit (config.home-manager.users.${META.user.username}.stylix.base16Scheme) base0D;
      inherit (config.home-manager.users.${META.user.username}.stylix.base16Scheme) base0E;
      inherit (config.home-manager.users.${META.user.username}.stylix.base16Scheme) base0F;

      conf = ''
        [General]
        #################### General ####################

        ScreenWidth="1920"
        ScreenHeight="1080"

        # Default 0, Options: from 0 to min(screen width/2,screen height/2). 
        ScreenPadding="5"

        Font="ESPACION"

        # Default is screen height divided by 80 (1080/80=13.5), Options: 0-inf.
        FontSize="12"

        #  Default 0.4, Options 0.1-1.0
        KeyboardSize="0.4"

        RoundCorners="20"

        # Locale for data and time format. I suggest leaving it blank.
        Locale=""

        # Default Locale.ShortFormat.
        HourFormat="HH:mm"

        # Default Locale.LongFormat.
        DateFormat="dddd d"

        # You can put something fun.
        HeaderText="$hostName"

        #################### Background ####################

        # Must be a relative path.
        # Background displayed before the actual background is loaded.
        # Use only if the background is a video, otherwise leave blank.
        # Connected with: Background.
        BackgroundPlaceholder=""

        # Must be a relative path.
        # Supports: png, jpg, jpeg, webp, gif, avi, mp4, mov, mkv, m4v, webm.
        Background="$image"

        # Default 1.0. Options: 0.0-10.0 (can go higher).
        # Speed of animated wallpaper.
        # Connected with: Background.
        BackgroundSpeed=""

        # Default false.
        # If set to true, stops playback of gifs. Works only with gifs.
        # Connected with: Background.
        PauseBackground=""

        # Options: 0.0-1.0.
        # Connected with: DimBackgroundColor
        DimBackground="0.0"

        # Default false.
        # Crop or fit background.
        # Connected with: BackgroundHorizontalAlignment and
        # BackgroundVerticalAlignment dosn't work when set to true.
        CropBackground="true"

        # Default: center, Options: left, center, right.
        # Horizontal position of the background picture.
        # Connected with: CropBackground must be set to false.
        BackgroundHorizontalAlignment="center"

        # Horizontal position of the background picture.
        # Default: center, Options: bottom, center, top.
        # Connected with: CropBackground must be set to false.
        BackgroundVerticalAlignment="center"

        #################### Colors ####################

        HeaderTextColor="$base05"
        DateTextColor="$base05"
        TimeTextColor="$base05"

        FormBackgroundColor="$base01"
        BackgroundColor="$base00"
        DimBackgroundColor="$base00"

        LoginFieldBackgroundColor="$base00"
        PasswordFieldBackgroundColor="$base00"
        LoginFieldTextColor="$base05"
        PasswordFieldTextColor="$base05"
        UserIconColor="$base05"
        PasswordIconColor="$base05"

        PlaceholderTextColor="$base03"
        WarningColor="$base05"

        LoginButtonTextColor="$base05"
        LoginButtonBackgroundColor="$base0D"
        SystemButtonsIconsColor="$base05"
        SessionButtonTextColor="$base05"
        VirtualKeyboardButtonTextColor="$base05"

        DropdownTextColor="$base05"
        DropdownSelectedBackgroundColor="$base0D"
        DropdownBackgroundColor="$base01"

        HighlightTextColor="$base00"
        HighlightBackgroundColor="$base05"
        HighlightBorderColor="$base05"

        HoverUserIconColor="$base0D"
        HoverPasswordIconColor="$base0D"
        HoverSystemButtonsIconsColor="$base0D"
        HoverSessionButtonTextColor="$base0D"
        HoverVirtualKeyboardButtonTextColor="$base0D"

        #################### Form ####################

        # Default false.
        PartialBlur="false"

        # Default false.
        # If you use FullBlur I recommend setting BlurMax to 64 and Blur to 1.0.
        FullBlur="false"

        # Default 48, Options: 2-64 (can go higher because depends on Blur).
        # Connected with: Blur.
        BlurMax="32"

        # Default 2.0, Options: 0.0-3.0 (without 3.0).
        # Connected with: BlurMax.
        Blur="1.0"

        # Form background is transparent if set to false.
        # Connected with: PartialBlur and BackgroundColor.
        HaveFormBackground="true"

        # Default: left, Options: left, center, right.
        FormPosition="left"

        #################### Virtual Keyboard ####################

        HideVirtualKeyboard="true"

        # Default: left, Options: left, center, right.
        VirtualKeyboardPosition="left"

        #################### Interface Behavior ####################

        HideSystemButtons="false"
        HideLoginButton="false"

        # If set to true last successfully logged in user appears
        # automatically in the username field.
        ForceLastUser="true"

        # Automatically focuses password field.
        PasswordFocus="true"

        # Hides the password while typing.
        HideCompletePassword="true"

        # Enable login for users without a password.
        AllowEmptyPassword="false"

        # Do not change this! Uppercase letters are generally not
        # allowed in usernames. This option is only for systems
        # that differ from this standard!
        AllowUppercaseLettersInUsernames="false"

        # Skips checking if sddm can perform shutdown, restart, 
        # suspend or hibernate, always displays all system buttons.
        BypassSystemButtonsChecks="false"

        # Revert the layout either because you would like the login
        # to be on the right hand side or SDDM won't respect your
        # language locale for some reason. This will reverse the
        # current position of FormPosition if it is either left or
        # right and in addition position some smaller elements on
        # the right hand side of the form itself (also when
        # FormPosition is set to center).
        RightToLeftLayout="false"

        #################### Translation ####################

        # These don't necessarily need to translate anything.
        # You can enter whatever you want here.

        TranslatePlaceholderUsername=""
        TranslatePlaceholderPassword=""
        TranslateLogin=""
        TranslateLoginFailedWarning=""
        TranslateCapslockWarning=""
        TranslateSuspend=""
        TranslateHibernate=""
        TranslateReboot=""
        TranslateShutdown=""
        TranslateSessionSelection=""
        TranslateVirtualKeyboardButtonOn=""
        TranslateVirtualKeyboardButtonOff=""
      '';

      unpackPhase = ''
        runHook preUnpack
        cp $src/share/sddm/themes/sddm-astronaut-theme/* --recursive $PWD
        echo "$conf" > theme.conf
        runHook postUnpack
      '';

      patchPhase = ''
        runHook prePatch
          
        # replace chosen theme into our custom theme.conf
        sed -i "s|^ConfigFile=Themes/.*\\.conf$|ConfigFile=theme.conf|" "$PWD/metadata.desktop"

        # fix the theme.conf file with our chose colour and images.
        sed -i "s|\\\$image|$image|g" "theme.conf"

        sed -i "s/\\\$hostName/$hostName/g" "theme.conf"

        # insert our chosen colours
        sed -i "s/\\\$base00/#$base00/g" "theme.conf"
        sed -i "s/\\\$base01/#$base01/g" "theme.conf"
        sed -i "s/\\\$base02/#$base02/g" "theme.conf"
        sed -i "s/\\\$base03/#$base03/g" "theme.conf"
        sed -i "s/\\\$base04/#$base04/g" "theme.conf"
        sed -i "s/\\\$base05/#$base05/g" "theme.conf"
        sed -i "s/\\\$base06/#$base06/g" "theme.conf"
        sed -i "s/\\\$base07/#$base07/g" "theme.conf"
        sed -i "s/\\\$base08/#$base08/g" "theme.conf"
        sed -i "s/\\\$base09/#$base09/g" "theme.conf"
        sed -i "s/\\\$base0A/#$base0A/g" "theme.conf"
        sed -i "s/\\\$base0B/#$base0B/g" "theme.conf"
        sed -i "s/\\\$base0C/#$base0C/g" "theme.conf"
        sed -i "s/\\\$base0D/#$base0D/g" "theme.conf"
        sed -i "s/\\\$base0E/#$base0E/g" "theme.conf"
        sed -i "s/\\\$base0F/#$base0F/g" "theme.conf"

        runHook postPatch
      '';

      installPhase = ''
        runHook preInstall
        mkdir -p "$out/share/sddm/themes/$name/"
        cp $PWD/* --recursive "$out/share/sddm/themes/$name/"
        runHook postInstall
      '';
    };
  };
in
{
  options.${namespace}.${module}.${program} = with types; {
    enable = mkOption {
      description = "Whether to this module.";
      default = config.${namespace}.${module}.enable;
      type = bool;
    };

    theme.name = mkOption {
      description = "The ${program}s' theme package' name.";
      default = theme.name;
      type = str;
    };

    theme.package = mkOption {
      description = "The ${program}s' theme package.";
      type = package;
      default = theme.package;
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = [
      cfg.theme.package
    ];

    environment.etc.${cfg.theme.name}.source = cfg.theme.package;

    services.displayManager.sddm = {
      enable = mkDefault true;
      autoNumlock = mkDefault true;
      theme = mkDefault cfg.theme.name;
      wayland.enable = mkDefault true;
      extraPackages = [
        cfg.theme.package
      ];
    };
  };

}
