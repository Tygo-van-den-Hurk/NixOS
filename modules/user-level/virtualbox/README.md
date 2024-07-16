> [!WARNING]
> This module can seriously slow down a rebuild as sometimes the entire virtual box needs to be downloaded and compiled from source. Using this module is discouraged.

# Virtual Box
VirtualBox is a powerful x86 and AMD64/Intel64 virtualization product for enterprise as well as home use. It allows you to spin up VMs really easily.

## Settings
This is what the options look like you can add to your machine-settings:
```NIX
{
    machine-settings.users.${user}.init.modules.virtualbox = {
        enable = boolean;
    }; 
}
```
