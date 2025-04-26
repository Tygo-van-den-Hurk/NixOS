> This module is used to make a NixOS system capable of gaming.

[< Back to system modules](../README.md)

# Gaming module

- [Gaming module](#gaming-module)
  - [Overview](#overview)
  - [Settings](#settings)
  - [External Resources](#external-resources)

## Overview
This module when loaded changes the settings in such a way that the system should be capable of gaming. It also installs Steam.

## Settings

This is what the options look like you can add to your machine-settings:

```Nix
{
  machine-settings.system.modules.gaming = {
    enable = boolean;
  };
}
```

## External Resources
Take a look at [this article on the NixOS wiki about Steam](https://nixos.wiki/wiki/Steam) for more information.
