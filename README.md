<div align="center">
  <a href="https://www.nixos.org/">
    <picture>
      <source srcset="./assets/images/svg/nixos-logo.light.svg" media="(prefers-color-scheme: light)">
      <img src="./assets/images/svg/nixos-logo.dark.svg" width="500px" alt="The NixOS logo">
    </picture>
  </a>
  <br>
  <br>
  <badges-section>
    <!--~###################################~-->
    <!--~####    Open issues and PRs    ####~-->
    <!--~###################################~-->
    <a href="https://github.com/Tygo-van-den-Hurk/NixOS/issues?q=is%3Aissue%20state%3Aopen%20label%3Afix">
      <picture>
        <source srcset="https://img.shields.io/github/issues/Tygo-van-den-Hurk/NixOS/fix?style=flat&labelColor=FFFFFF&color=5277c3&logoColor=5E2751&label=Bug%20Reports" media="(prefers-color-scheme: light)" />
        <img src="https://img.shields.io/github/issues/Tygo-van-den-Hurk/NixOS/fix?style=flat&labelColor=2F363D&color=415e9a&logoColor=8F5C86&label=Bug%20Reports" alt="open bug reports" />
      </picture>
    </a>
    <a href="https://github.com/Tygo-van-den-Hurk/NixOS/issues?q=is%3Aissue%20state%3Aopen%20label%3Afeat">
      <picture>
        <source srcset="https://img.shields.io/github/issues/Tygo-van-den-Hurk/NixOS/feat?style=flat&labelColor=FFFFFF&color=5277c3&logoColor=5E2751&label=Feature%20Requests" media="(prefers-color-scheme: light)" />
        <img src="https://img.shields.io/github/issues/Tygo-van-den-Hurk/NixOS/feat?style=flat&labelColor=2F363D&color=415e9a&logoColor=8F5C86&label=Feature%20Requests" alt="open feature requests" />
      </picture>
    </a>
    <br>
    <!--~###################################~-->
    <!--~####     Repository Stats      ####~-->
    <!--~###################################~-->
    <a href="./LICENSE">
      <picture>
        <source srcset="https://img.shields.io/github/license/Tygo-van-den-Hurk/NixOS?style=flat&labelColor=FFFFFF&color=5277c3&logoColor=5E2751&label=Licence" media="(prefers-color-scheme: light)" />
        <img src="https://img.shields.io/github/license/Tygo-van-den-Hurk/NixOS?style=flat&labelColor=2F363D&color=415e9a&logoColor=8F5C86&label=Licence" alt="The Repository License badge" />
      </picture>
    </a>
    <a href="https://github.com/Tygo-van-den-Hurk/NixOS/stargazers">
      <picture>
        <source srcset="https://img.shields.io/github/stars/Tygo-van-den-Hurk/NixOS?style=flat&labelColor=FFFFFF&color=5277c3&label=Stars" media="(prefers-color-scheme: light)" />
        <img src="https://img.shields.io/github/stars/Tygo-van-den-Hurk/NixOS?style=flat&labelColor=2F363D&color=415e9a&label=Stars" alt="amount of stars on GitHub" />
      </picture>
    </a>
    <a href="https://github.com/Tygo-van-den-Hurk/NixOS/releases">
    <picture>
        <source srcset="https://img.shields.io/github/release/Tygo-van-den-Hurk/NixOS?style=flat&display_name=release&label=Release&labelColor=FFFFFF&color=5277c3" media="(prefers-color-scheme: light)" />
        <img src="https://img.shields.io/github/release/Tygo-van-den-Hurk/NixOS?style=flat&display_name=release&label=Release&labelColor=2F363D&color=415e9a" alt="newest release" />
    </picture>
    </a>
    <br>
    <!--~###################################~-->
    <!--~####      Repository CI/CD     ####~-->
    <!--~###################################~-->
    <a href="https://github.com/Tygo-van-den-Hurk/NixOS/actions/workflows/many--nix-flake-check.yaml">
      <picture>
        <source srcset="https://img.shields.io/github/actions/workflow/status/Tygo-van-den-Hurk/NixOS/many--nix-flake-check.yaml?style=flat&labelColor=FFFFFF&color=5277c3&logo=GitHub%20Actions&logoColor=000000&branch=main&event=push&label=Build" media="(prefers-color-scheme: light)" />
        <img src="https://img.shields.io/github/actions/workflow/status/Tygo-van-den-Hurk/NixOS/many--nix-flake-check.yaml?style=flat&labelColor=2F363D&color=415e9a&logo=GitHub%20Actions&logoColor=FFFFFF&branch=main&event=push&label=Build" alt="Build status" />
      </picture>
    </a>
    <a href="https://github.com/Tygo-van-den-Hurk/NixOS/actions/workflows/push--deploy-github-pages.yaml">
      <picture>
        <source srcset="https://img.shields.io/github/actions/workflow/status/Tygo-van-den-Hurk/NixOS/push--deploy-github-pages.yaml?style=flat&labelColor=FFFFFF&color=5277c3&logo=GitHub%20Actions&logoColor=000000&branch=main&event=push&label=Docs" media="(prefers-color-scheme: light)" />
        <img src="https://img.shields.io/github/actions/workflow/status/Tygo-van-den-Hurk/NixOS/push--deploy-github-pages.yaml?style=flat&labelColor=2F363D&color=415e9a&logo=GitHub%20Actions&logoColor=FFFFFF&branch=main&event=push&label=Docs" alt="Documentation build status" />
      </picture>
    </a>
  </badges-section>
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
