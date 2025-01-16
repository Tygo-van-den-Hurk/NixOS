> This submodule is used to configure i3wm a tiling window manager.

[< Back to GUI module](../README.md)

# i3 Window Manager

- [i3 Window Manager](#i3-window-manager)
  - [Overview](#overview)
  - [Settings](#settings)

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
