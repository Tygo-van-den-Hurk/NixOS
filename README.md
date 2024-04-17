> This repository contains the the configuration files for the NixOS.

# NixOS

<div style="background-color: white; padding: 1em; border-radius: 1em;">
        <img alt="The NixOS logo" src="https://raw.githubusercontent.com/NixOS/nixos-artwork/master/logo/nixos.svg" style="margin-left: auto; margin-right: auto; max-width: 300px; width: 100%">
</div>

## What is NixOS?
NixOS is a Declarative linux distribution that allows reproducibility, and focuses of reliability.

### Reproducible
Nix builds packages in isolation from each other. This ensures that they are reproducible and don’t have undeclared dependencies, so if a package works on one machine, it will also work on another.
Declarative

### Declarative
Nix makes it trivial to share development and build environments for your projects, regardless of what programming languages and tools you’re using.
Reliable

### Reliable
Nix ensures that installing or upgrading one package cannot break other packages. It allows you to roll back to previous versions, and ensures that no package is in an inconsistent state during an upgrade.


## the Structure of this repository
This repository has 3 main directories:
- **Modules**: *is used to store a set of modules a `system` can load.*
- **Systems**: *the systems that I've configured. Load modules from* `modules/` *.*
- **Users**: *this is were the home-manager data will be stored*
```
NixOS/
├── systems/
│   ├── category/
│   │   ├── specific-machine/
│   │   │   ├── configuration.nix
│   │   │   ├── hardware-configuration.nix
│   │   │   └── settings.nix
│   │   ├── ... 
│   │   └── common-settings.nix
│   ├── ... 
│   └── common-settings.nix
│   
├── modules/
│   │
│   ├── module/
│   │   ├── ...
│   │   └── default.nix
│   │
│   │ ...
│   
├── user/
│   ├── tygo/
│       └── ...
│
├── flake.nix
└── flake.lock
```

There is also the `flake.nix`, and `flake.lock` of course here at the root. The flow is as follows: 
- the flake takes the argument from the CLI and loads the *system* from `./systems/`
- the *system* loads the *modules* it needs from `./modules/`
- the *system* builds the home directory from the `./users/` folder

## Learn NixOS
These video's helped me with building my own configuration file. 

│ Name                                                      │ link                                        │
│-----------------------------------------------------------│---------------------------------------------│
│ NixOS Setup Guide - Configuration / Home-Manager / Flakes │ https://www.youtube.com/watch?v=AGVXJ-TIv3Y │
│ How to Start Adding Modularity to Your NixOS Config       │ https://www.youtube.com/watch?v=bV3hfalcSKs │

## Todo List
this is a todo-list of things we still need to do to get this system as I'd like. After all these are done, it will become a feature list!

- [x] modularity of the configurations:  
  - [x] create the 'module loader' that loads modules based on settings.  
  - [x] make it possible to load the config of a certain machine using the flake.  
- [ ] usability:
  - [x] Add "boot to windows" option when booting up.  
  - [ ] Fix keybindings using the config files so that every machine is immediately fixed.  
  - [ ] configure the a window manager.  
  - [ ] install all apps that you want.  
