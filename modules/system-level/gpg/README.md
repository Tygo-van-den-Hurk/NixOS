> This module is used to configure the Gnu Privacy Guard service.

[< Back to system modules](../README.md)

# GPG 

GPG (Gnu Privacy Guard) allows you to encrypt and sign your data and communications; it features a versatile key management system, along with access modules for all kinds of public key directories. GnuPG, also known as GPG, is a command line tool with features for easy integration with other applications.


## Settings

This is what the options look like you can add to your machine-settings:

```Nix
{
    machine-settings.system.modules.gpg = {
        enable = boolean;
    };
}
```
