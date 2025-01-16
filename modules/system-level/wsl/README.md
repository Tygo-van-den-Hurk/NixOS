> This module imports and uses settings needed for running nix in WSL. 

[< Back to system modules](../README.md)

# WSL

- [WSL](#wsl)
  - [Overview](#overview)
  - [Settings](#settings)
  - [External Resources](#external-resources)

## Overview

Windows Subsystem for Linux (WSL) is a feature of Windows that allows you to run a Linux environment on your Windows machine, without the need for a separate virtual machine or dual booting. WSL is designed to provide a seamless and productive experience for developers who want to use both Windows and Linux at the same time.

## Settings

This is what the options look like you can add to your machine-settings:

```Nix
{
  machine-settings.system.modules.wsl = {
    enable = boolean;
    defaultUser = string; # Must be a username that is on this system.
  };
}
```

## External Resources
Take a look at [this guide](https://nixos.wiki/wiki/WSL) for more information.
