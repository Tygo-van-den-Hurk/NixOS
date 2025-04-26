> This module imports and uses settings needed for running [via](https://www.caniusevia.com/) on NixOS. 

[< Back to system modules](../README.md)

# Via

- [Via](#via)
  - [Overview](#overview)
  - [Settings](#settings)
  - [External Resources](#external-resources)

## Overview

VIA works like an add-on firmware to QMK, and it lets you modify your keyboard’s keymap without you having to reflash the firmware with every modification and without having to program any instructions. Also, all the modifications you make remain on the keyboard, such that even when you unplug and replug it, or connect it to a new computer, the keymap configuration will still be retained.

VIA also comes with tools to work with, which are VIA Firmware and VIA Configurator. The VIA firmware is pretty much the same as QMK firmware, except that the former now has the VIA_ENABLE feature enabled. The configurator then lets you do all your modifications, including keyboard remapping, light control, macros programming, and layout controls.

## Settings

This is what the options look like you can add to your machine-settings:

```Nix
{
  machine-settings.system.modules.via = {
    enable = boolean;
  };
}
```

## External Resources
Take a look at [this guide](https://nixos.wiki/wiki/Qmk) for more information.
