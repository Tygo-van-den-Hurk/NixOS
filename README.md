> This repository contains the the configuration files for the NixOS.

# NixOS


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

There is also the `flake.nix`, and `flake.lock` of course here at the root. The flow is as follows: 
- the flake takes the argument from the CLI and loads the *system* from `./systems/`
- the *system* loads the *modules* it needs from `./modules/`
- the *system* builds the home directory from the `./users/` folder

## Learn NixOS
These video's helped me with building my own configuration file. 
| Name | link|
|---|---|
| NixOS Setup Guide - Configuration / Home-Manager / Flakes | https://www.youtube.com/watch?v=AGVXJ-TIv3Y |
| How to Start Adding Modularity to Your NixOS Config | https://www.youtube.com/watch?v=bV3hfalcSKs |


## Todo List
this is a todo-list of things we still need to do to get this system as I'd like:
- [ ] modularity of the configurations:  
  - [x] create a structure in such a way that different machines can load different modules  
  - [ ] make it possible to load the config of a certain machine using the flake
- [ ] usability
  - [x] Add "boot to windows" option when booting up  
  - [ ] Fix keybindings using the config files so that every machine is immediately fixed.  
  - [ ] configure the a window manager  
  - [ ] install all apps  
