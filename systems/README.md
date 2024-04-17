# Systems
In this directory I'll store the systems I'm maintaining with NixOS. 

## Structure
The structure of this directory is as follows: 
```
systems/
├── category/
│   ├── specific-machine/
│   │   ├── configuration.nix
│   │   ├── hardware-configuration.nix
│   │   └── settings.nix
│   ├── ... 
│   └── common-settings.nix
├── ... 
└── common-settings.nix
```
Where there are multiple categories like for example:
- Laptops
- Desktops
- WSLs
- Virtual Machines