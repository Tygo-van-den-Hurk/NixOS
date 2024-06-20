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

## Settings
Settings are what loads and unloads modules. The settings have the following schema:
```NIX
machine-settings = {
    users  = { ... };
    system = { ... };
};
```

### Users
The `users` settings is a set of `Users`. This is what a users attribute set looks like with one user:
```NIX
users = {

    username = {
        description     = string;  # Your full name
        isNormalUser    = boolean; #
        initialPassword = string   # the initial password for the user
        isNormalUser    = boolean; # wether or not you're a human user
        init = {
            modules         = { ... };
            packages        = { ... };
        };
    };
};
```

#### Modules
The user has a couple of modules that they can enable. You can read more about it [here](../modules/README.md).

#### Packages
This option stores information about the user packages. Meaning that any package listed here will be available system wide. Not that some modules can add packages by them selfs. For example, enabling docker will make docker available to the user.

### System
The `system` option is a set with a few options, here is an overview:
```NIX
system = {
    hostname      = string;
    architecture  = string;
    packages      = { ... };
    modules       = { ... }; 
};
```

#### Modules
There are a few system level modules that can be enabled. You can read more about it [here](../modules/README.md).

#### Packages
This option stores information about the system packages. Meaning that any package listed here will be available system wide. Not that some modules can add packages by them selfs. For example, enabling docker will make docker available to the user.
