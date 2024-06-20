# WSL
Windows Subsystem for Linux (WSL) is a feature of Windows that allows you to run a Linux environment on your Windows machine, without the need for a separate virtual machine or dual booting. WSL is designed to provide a seamless and productive experience for developers who want to use both Windows and Linux at the same time.

## Settings
This is what the options look like you can add to your machine-settings:
```Nix
{
    machine-settings.system.modules.wsl = {
        enable = boolean;
        defaultUser = string;
    };
}
```