> This module will load and configure the open shh service.

[< Back to system modules](../README.md)

# open SSH

- [open SSH](#open-ssh)
  - [Overview](#overview)
  - [Settings](#settings)
  - [External Resources](#external-resources)

## Overview

This module enables SSH and Fail2Ban a service that bans ips if they try to many times. Secure Shell (SSH) is a cryptographic protocol that allows remote access and operation of network services over an unsecured network. It uses public-key authentication, encryption, and tunneling to protect data and user identities. 

## Settings

This is what the options look like you can add to your machine-settings:

```Nix
{
  machine-settings.system.modules.openssh = {
    enable = boolean;
  };
}
```

## External Resources
Take a look at [this guide](https://nixos.wiki/wiki/SSH) for more information. Another highly important guide is the [Fail2ban guide](https://nixos.wiki/wiki/Fail2ban).
