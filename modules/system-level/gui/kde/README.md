> This submodule is used to configure KDE a desktop environment.


[< Back to GUI module](../README.md)

# KDE

- [KDE](#kde)
  - [Overview](#overview)
  - [Settings](#settings)

## Overview

KDE Plasma is a graphical desktop environment with customizable layouts and panels, supporting virtual desktops and widgets. Written with Qt and KDE Frameworks.

## Settings

This is what the options look like you can add to your machine-settings:

```Nix
{
  machine-settings.system.modules.gui.kde = {
    enable = boolean;
  };
}
```
