# Local AI
This module defines the Ollama, and open-webui containers to run on this host. It even tries to optimize depending on the other modules loaded. For example if the NVIDIA drivers are loaded, then ollama will use Cude to run the models.

## What is the point of this?
Well, you'll always have a fast, and competent AI with you on the go. With the ability to read from your file system as needed.

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

## Note
Created with help of [this guide](https://fictionbecomesfact.com/nixos-ollama-oterm-openwebui). To debug a docker container use: 

```BASH
journalctl _SYSTEMD_INVOCATION_ID=$(systemctl show -p InvocationID --value docker-open-webui.service) --no-pager
```
