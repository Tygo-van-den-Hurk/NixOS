> This module will load and configure the ollama service and start up an openwebUI container.

[< Back to system modules](../README.md)

# Local AI

- [Local AI](#local-ai)
  - [Overview](#overview)
  - [Settings](#settings)
  - [Debug](#debug)
  - [External Resources](#external-resources)

## Overview 

This module defines the Ollama, and open-webui containers to run on this host. It even tries to optimize depending on the other modules loaded. For example if the NVIDIA drivers are loaded, then ollama will use Cuda to run the models. This module gives you a fast, and competent AI with you on the go. With the ability to read from your file system as needed.

## Settings

This is what the options look like you can add to your machine-settings:

```Nix
{
  machine-settings.system.modules.local-ai = {
    enable = boolean;
    backend = string;
    acceleration = string;
    devices = {
      cuda  = string;
      hip   = string;
    };
  };
}
```

## Debug

To debug a docker container use: 

```BASH
journalctl _SYSTEMD_INVOCATION_ID=$(systemctl show -p InvocationID --value docker-open-webui.service) --no-pager
```

## External Resources

There is a [guide](https://fictionbecomesfact.com/nixos-ollama-oterm-openwebui) to learn how this module works internally. This is what I followed to make this module.
