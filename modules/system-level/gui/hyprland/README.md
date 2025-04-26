# Hyperland

- [Hyperland](#hyperland)
  - [Overview](#overview)
  - [Settings](#settings)
  - [External Resources](#external-resources)

## Overview
Hyprland is a wlroots-based tiling Wayland compositor written in C++. Noteworthy features of Hyprland include dynamic tiling, tabbed windows, a clean and readable C++ code-base, and a custom renderer that provides window animations, rounded corners, and Dual-Kawase Blur on transparent windows. General usage and configuration is thoroughly documented at [Hyprland wiki](https://wiki.hyprland.org/). 

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
[Vimjoyer's youtube video on Nixos and Hyprland](https://www.youtube.com/watch?v=61wGzIv12Ds) is a great guide on how to get started. There is of course also [the NixOS wiki](https://nixos.wiki/wiki/Hyprland). For other questions you can search the [Hyprland wiki](https://wiki.hyprland.org/).
