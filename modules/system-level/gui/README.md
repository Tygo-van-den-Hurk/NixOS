> This module will load and configure the desktop environments / window managers.

[< Back to system modules](../README.md)

# Graphical User Interface

- [Graphical User Interface](#graphical-user-interface)
  - [Overview](#overview)
  - [Settings](#settings)

## Overview
A graphical user interface, or GUI, is a form of user interface that allows users to interact with electronic devices through graphical icons and visual indicators such as secondary notation. In many applications, GUIs are used instead of text-based UIs, which are based on typed command labels or text navigation. GUIs were introduced in reaction to the perceived steep learning curve of command-line interfaces, which require commands to be typed on a computer keyboard. 

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
