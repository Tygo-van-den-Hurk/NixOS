> This repository contains the the configuration files for the NixOS.

<br>
<div align="center">
  <a href="https://github.com/Tygo-van-den-Hurk/NixOS/graphs/contributors">
    <img src="https://img.shields.io/github/contributors/Tygo-van-den-Hurk/NixOS?style=flat" alt="Contributors"/>
  </a>
  <a href="https://github.com/Tygo-van-den-Hurk/NixOS/blob/main/LICENSE">
    <img src="https://img.shields.io/github/license/Tygo-van-den-Hurk/NixOS?style=flat" alt="The Eclipse Public License v2.0 badge" />
  </a>
  <a href="https://github.com/Tygo-van-den-Hurk/NixOS/commit">
    <img src="https://badgen.net/github/last-commit/Tygo-van-den-Hurk/NixOS?style=flat" alt="GitHub latest commit" />
  </a>
  <a href="https://github.com/Tygo-van-den-Hurk/NixOS/release">
    <img src="https://img.shields.io/github/release/Tygo-van-den-Hurk/NixOS?style=flat&display_name=release" alt="newest release" />
  </a>
  <a href="https://github.com/Tygo-van-den-Hurk/NixOS/pulse">
    <img src="https://img.shields.io/github/created-at/Tygo-van-den-Hurk/NixOS?style=flat" alt="created at badge" />
  </a>
  <a href="https://github.com/Tygo-van-den-Hurk/NixOS/">
    <img src="https://img.shields.io/github/repo-size/Tygo-van-den-Hurk/NixOS?style=flat" alt="the size of the repository" />
  </a> 
  <a href="https://github.com/Tygo-van-den-Hurk/NixOS/commit">
    <img src="https://badgen.net/github/commits/Tygo-van-den-Hurk/NixOS?style=flat" alt="GitHub commits" />
  </a>
  <a href="https://github.com/Tygo-van-den-Hurk/NixOS/network/">
    <img src="https://badgen.net/github/forks/Tygo-van-den-Hurk/NixOS?style=flat" alt="GitHub forks" />
  </a>
  <a href="https://github.com/Tygo-van-den-Hurk/NixOS/stargazers">
    <img src="https://img.shields.io/github/stars/Tygo-van-den-Hurk/NixOS?style=flat" alt="amount of stars" />
  </a>
  <a href="https://github.com/Tygo-van-den-Hurk/NixOS/">
    <img src="https://img.shields.io/github/languages/count/Tygo-van-den-Hurk/NixOS?style=flat" alt="amount of languages in the repository" />
  </a>      
  <br><br>
  <picture>
    <source srcset="./assets/images/svg/nixos-logo-black.svg" media="(prefers-color-scheme: light)">
    <source srcset="./assets/images/svg/nixos-logo-white.svg" media="(prefers-color-scheme: dark)">
    <img src="./assets/images/svg/nixos-logo-black.svg" width="500px" alt="the NixOS logo">
  </picture>
</div>

# NixOS

This repository contains my configuration files for my Linux distribution of choice: [NixOS](https://www.nixos.org/). NixOS is special in the sense that it allows to configure all services, users, files, mounts, all via configuration files. Making the exact state of the system reproducible.

## Pros of using NixOS

Here are some of the reasons you might want to use NixOS:

### 1. Reproducible

Nix builds packages in isolation from each other. This ensures that they are reproducible and don’t have undeclared dependencies, so if a package works on one machine, it will also work on another.
Declarative

### 2. Declarative

Nix makes it trivial to share development and build environments for your projects, regardless of what programming languages and tools you’re using.

### 3. Reliable

Nix ensures that installing or upgrading one package cannot break other packages. It allows you to roll back to previous versions, and ensures that no package is in an inconsistent state during an upgrade.

## Structure of this Repository

This repository has 2 main directories:
- **Systems**: the systems that I've configured. Load modules from [`modules/`](./modules/README.md). You can learn more about the systems directory [in the systems README](./systems/README.md).
- **Modules**: is used to store a set of modules a [`system`](./systems/README.md) can load. You can learn more about that [in the modules README](./modules/README.md).

Here is an overview of the structure:

```
NixOS/
├── systems/
├── modules/
├── flake.nix
└── flake.lock
```

There is also the [`flake.nix`](./flake.nix), and [`flake.lock`](./flake.lock) of course here at the root to make the systems completely reproducible. 

The flow is as follows: 
- The flake takes the argument from the CLI and loads the *system* from [`./systems/`](./systems/README.md) somewhere.
- That *system* loads the *module* loader at [`/modules/default.nix`](./modules/default.nix), which you can read more about [here](./modules/README.md).
- The **module loader** loads the modules specified in the [**machines settings**](./systems/common-settings.nix).

You can learn more about the structure of the [systems directory](./systems/README.md#structure), [modules directory](./modules/README.md#structure), or [user directory](./systems/README.md#structure) by clicking these links.

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
