> This repository contains the the configuration files for the NixOS.

# NixOS

![The NixOS logo](./nixos-logo.svg)

## What is NixOS?
NixOS is a Declarative linux distribution that allows reproducibility, and focuses of reliability.

### 1. Reproducible
Nix builds packages in isolation from each other. This ensures that they are reproducible and don’t have undeclared dependencies, so if a package works on one machine, it will also work on another.
Declarative

### 2. Declarative
Nix makes it trivial to share development and build environments for your projects, regardless of what programming languages and tools you’re using.
Reliable

### 3. Reliable
Nix ensures that installing or upgrading one package cannot break other packages. It allows you to roll back to previous versions, and ensures that no package is in an inconsistent state during an upgrade.

## Structure of this Repository
This repository has 3 main directories:
- **Systems**: *the systems that I've configured. Load modules from* [`modules/`](./modules/README.md) *. You can learn more about that module [here](./systems/README.md).*
- **Modules**: *is used to store a set of modules a [`system`](./systems/README.md) can load. You can learn more about that module [here](./modules/README.md).*
- **Users**: *this is were the home-manager data will be stored. You can read more about that module [here](./users/README.md).*

Here is an overview of the structure:

```
NixOS/
├── library/
├── systems/
├── modules/
├── user/
├── flake.nix
└── flake.lock
```

There is also the [`flake.nix`](./flake.nix), and [`flake.lock`](./flake.lock) of course here at the root. The flow is as follows: 
- The flake takes the argument from the CLI and loads the *system* from [`./systems/`](./systems/README.md) somewhere.
- That *system* loads the *module* loader at [`/modules/default.nix`](./modules/default.nix), which you can read more about [here](./modules/README.md).
- The **module loader** loads the modules specified in the [**machines settings**](./systems/common-settings.nix).

You can learn more about the structure of the [systems directory](./systems/README.md#structure), [modules directory](./modules/README.md#structure), or [user directory](./systems/README.md#structure) by clicking these links.

## Todo List
This is a todo-list of things we still need to do to get this system as I'd like. After all these are done, it will become a feature list! [Go to To Do list](./TODO-LIST.md)

## Learn NixOS
These resources helped me with building my own configuration file:

<table>
  <tr>
    <th>Name</th>
    <th>Link</th>
    <th>Explanation</th>
  </tr>
  <tr>
    <td>NixOS Setup Guide - Configuration / Home-Manager / Flakes</td>
    <td><a href="https://www.youtube.com/watch?v=AGVXJ-TIv3Y">YouTube</a></td>
    <td>A good start/run down of how to make your NixOS config.</td>
  </tr>
  <tr>
    <td>How to Start Adding Modularity to Your NixOS Config</td>
    <td><a href="https://www.youtube.com/watch?v=bV3hfalcSKs">YouTube</a></td>
    <td>A guid to modularity. I recommend all his video's.</td>
  </tr>
  <tr>
    <td>Nix Packages Manual</td>
    <td><a href="https://ryantm.github.io/nixpkgs/">ryantm's GitHub Pages</a></td>
    <td>Contains SO MANY useful library functions and their descriptions.</td>
  </tr>
</table>
