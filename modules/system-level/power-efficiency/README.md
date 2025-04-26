> This module aims to import battery life, and lower power consumption. 

[< Back to system modules](../README.md)

# Power Efficiency

- [Power Efficiency](#power-efficiency)
  - [Overview](#overview)
  - [Settings](#settings)
  - [External Resources](#external-resources)

## Overview

This module loads and optimises some settings to optimise battery life. This is important for laptops and home servers who need to watch their power consumption more closely.

## Settings

This is what the options look like you can add to your machine-settings:

```Nix
{
  machine-settings.system.modules.power-efficiency = {
    enable = boolean;
  };
}
```

## External Resources
Take a look at [the NixOS article on laptops and power saving](https://nixos.wiki/wiki/Laptop) for more information.
