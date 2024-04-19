# Modules
In this directory I'll store all the configuration files that can be used to add or remove some feature from a system. Every module will add or remove one feature. So the gaming module will only enable gaming.

The most important module is the [common/](./common/README.md) module, as this module has all the settings that each of the systems is going to use. This module will also be imported by every system. This is the only module that cannot be excluded from the loading process.

## Structure
The modules directory is where all the modules get stored. Each module is supposed to have a setting named `modules.moduleName` that can be either true, or false. One important note is that the module must have the same name as it's setting to prevent confusion. So the setting `modules.moduleName` implies there is a file called `default.nix` at `/modules/moduleName/`. 

Which brings us to our next point, how are those modules being loaded and ignored?

```
NixOS/
├── modules/
│   ├── moduleName/
│   │   ├── ...
│   │   └── default.nix
│   │ ...
│   └── default.nix
│ ...
```

This is why every system at `/systems/category/machine/` imports `/modules/` the file that gets loaded is `/modules/default.nix`. Which in turn takes the `machine-settings` argument, and loads the modules as needed. The `/modules/default.nix` loads the  `/modules/moduleName/default.nix` file if the settings match. Do **not** load modules individually. 
