> This submodule is used to configure [the i3wm a tiling window manager](https://i3wm.org/).

[< Back to GUI module](../README.md)

> [!WARNING]
> This GUI is quite old and has problems with screen tearing for example. It shall at some point be replaced with [Hyperland](../hyprland/README.md) when that is ready. 

# i3 Window Manager

- [i3 Window Manager](#i3-window-manager)
  - [Overview](#overview)
  - [Settings](#settings)
  - [External Resources](#external-resources)

## Overview
i3 is a tiling window manager, completely written from scratch. The target platforms are GNU/Linux and BSD operating systems, our code is Free and Open Source Software (FOSS) under the BSD license. i3 is primarily targeted at advanced users and developers.

## Settings
This is what the options look like you can add to your machine-settings:

```Nix
{
  machine-settings.system.modules.gui.i3wm = {
    enable = boolean;
  };
}
```

## External Resources
The [i3wm documentation](https://i3wm.org/docs/) and [the i3wm NixOS wiki article](https://nixos.wiki/wiki/I3) are both great places for more information.
