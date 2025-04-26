> This submodule is used to configure the [KDE desktop environment](https://kde.org/).

[< Back to GUI module](../README.md)

> [!WARNING]
> This module is deprecated and will be removed at some point as I have no need for any GUI other then my main tiling window manager, and maintaining multiple modules I won't use is extra effort.

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
