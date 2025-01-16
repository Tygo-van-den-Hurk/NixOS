> This submodule is used to configure Gnome a complete desktop environment.

[< Back to GUI module](../README.md)

# Gnome

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
