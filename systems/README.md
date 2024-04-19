# Systems
In this directory I'll store the systems I'm maintaining with NixOS. 

## Structure
The systems directory is where all the systems are stored. They are divided by category. So an example for a system is a Thinkpad, this is a laptop. So it's configuration file is stored at `/systems/laptops/thinkpad/`. 

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
│ ...
```

Every system has a few common files. These are: `default.nix`, `hardware-configuration.nix`, and `settings.nix`. 

First, `default.nix` is what gets loaded when a system get's loaded. In this file, you have the possibility to write overriding configuration options though this is discouraged. I'd recommend writing a module instead, and adding a setting for it in `/systems/common-settings.nix` and then enabling it for that machine.

Next, `hardware-configuration.nix` is created when you first boot into NixOS, and I'd recommend you just paste that into the folder of that machine. I'd also recommend editing it unless you know what you're doing.

Lastly, `settings.nix` is where the settings can be overwritten for a particular machine. An example of a setting I would override is `system.hostname`, as every machine needs it's own hostname. if you leave a setting out of this file, it will go to the defaults of that category. That is why `/systems/category/common-settings.nix` exist. Here you can override settings for all machines of that category. The category settings, when unspecified in turn go to the overal system settings in `/systems/common-settings.nix`.
