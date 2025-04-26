> This module imports and uses settings needed for running [VirtualBox](https://www.virtualbox.org/) on NixOS. 

[< Back to user modules](../README.md)

> [!WARNING]
> This module can seriously slow down a rebuild as sometimes the entire virtual box needs to be downloaded and compiled from source. Using this module is discouraged.

# Virtual Box

- [Virtual Box](#virtual-box)
  - [Overview](#overview)
  - [Settings](#settings)
  - [External Resources](#external-resources)

## Overview 
VirtualBox is a powerful x86 and AMD64/Intel64 virtualization product for enterprise as well as home use. It allows you to spin up VMs really easily.

## Settings
This is what the options look like you can add to your machine-settings:

```Nix
{
  machine-settings.users.${user}.init.modules.virtualbox = {
    enable = boolean;
  }; 
}
```

## External Resources
Take a look at [the VirtualBox NixOS wiki article](https://nixos.wiki/wiki/VirtualBox) for more information.
