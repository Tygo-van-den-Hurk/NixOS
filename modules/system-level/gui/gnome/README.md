> This submodule is used to configure [the Gnome desktop environment](https://www.gnome.org/).

[< Back to GUI module](../README.md)

> [!WARNING]
> This module is deprecated and will be removed at some point as I have no need for any GUI other then my main tiling window manager, and maintaining multiple modules I won't use is extra effort.


> [!WARNING]
> This module is broken last time I checked and doesn't load Gnome properly

# Gnome

- [Gnome](#gnome)
  - [Overview](#overview)
  - [Settings](#settings)
  - [External Resources](#external-resources)

## Overview
GNOME, originally an acronym for GNU Network Object Model Environment, is a free and open-source desktop environment for Linux and other Unix-like operating systems. 

## Settings
This is what the options look like you can add to your machine-settings:

```Nix
{
  machine-settings.system.modules.gui.gnome = {
    enable = boolean;
  };
}
```

## External Resources
You can find more information on [the GNOME NixOS wiki article](https://nixos.wiki/wiki/GNOME).
