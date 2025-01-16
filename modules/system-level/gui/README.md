> This module will load and configure the desktop environments / window managers.

[< Back to system modules](../README.md)

# Graphical User Interface

- [Graphical User Interface](#graphical-user-interface)
  - [Settings](#settings)
- [Configurations for the Window Manager](#configurations-for-the-window-manager)
  - [Work Spaces / Virtual Desktops](#work-spaces--virtual-desktops)
  - [Key bindings](#key-bindings)
    - [How much should an action occur](#how-much-should-an-action-occur)
      - [Moving Focus between Work Spaces or Displays](#moving-focus-between-work-spaces-or-displays)
      - [Moving Windows between Work Spaces or Displays](#moving-windows-between-work-spaces-or-displays)
      - [Moving Focus on the same Work Spaces and Display](#moving-focus-on-the-same-work-spaces-and-display)
      - [Moving Windows on the same Work Spaces and Display](#moving-windows-on-the-same-work-spaces-and-display)
      - [Switching to an application at an unknown location](#switching-to-an-application-at-an-unknown-location)
      - [Switching layouts](#switching-layouts)
      - [The results](#the-results)
    - [Moving Focus between Work Spaces](#moving-focus-between-work-spaces)
    - [Moving Focus between Displays](#moving-focus-between-displays)
    - [Moving Windows between Work Spaces](#moving-windows-between-work-spaces)
    - [Moving Windows between Displays](#moving-windows-between-displays)
    - [Moving Focus between windows on the same Work Space and Display](#moving-focus-between-windows-on-the-same-work-space-and-display)
    - [Moving Windows on the same Work Space and Display](#moving-windows-on-the-same-work-space-and-display)
    - [Switching focus to a different windows at an unknown location.](#switching-focus-to-a-different-windows-at-an-unknown-location)
    - [Switching layouts](#switching-layouts-1)
    - [Other important notes](#other-important-notes)

## Settings

This is what the options look like you can add to your machine-settings:

```Nix
{
  machine-settings.system.modules.gui = {
    enable = boolean;

    # And which one to enable: (throws error if it is more then one)
    gnome.enable = boolean;
    hyprland.enable = boolean;
    i3wm.enable = boolean;
    kde.enable = boolean;
  };
}
```
