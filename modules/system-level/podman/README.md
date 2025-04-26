> This module will load and configure the Podman container engine.

[< Back to system modules](../README.md)

# Podman

- [Podman](#podman)
  - [Overview](#overview)
  - [Settings](#settings)
  - [External Resources](#external-resources)

## Overview

Podman is a daemonless, open source, Linux native tool designed to make it easy to find, run, build, share and deploy applications using Open Containers Initiative (OCI) Containers and Container Images. Podman provides a command line interface (CLI) familiar to anyone who has used the Docker Container Engine. Most users can simply alias Docker to Podman (`alias docker=podman`) without any problems. Similar to other common Container Engines (Docker, CRI-O, containerd), Podman relies on an OCI compliant Container Runtime (runc, crun, runv, etc) to interface with the operating system and create the running containers. This makes the running containers created by Podman nearly indistinguishable from those created by any other common container engine.

## Settings

This is what the options look like you can add to your machine-settings:

```Nix
{
  machine-settings.system.modules.podman = {
    enable = boolean;
    dockerCompat = boolean;
  };
}
```

## External Resources
Take a look at [the Podman NixOS wiki article](https://nixos.wiki/wiki/Podman) for more information.
