# SSH
SSH, also known as Secure Shell or Secure Socket Shell, is a network protocol that gives users, particularly system administrators, a secure way to access a computer over an unsecured network.

## Settings
This is what the options look like you can add to your machine-settings:
```NIX
{
    system.modules.modules.openssh = {
        enable  = boolean;
    };

    users.${username}.openssh.authorizedKeys.keys = [ strings ];
}
```

### SSH Keys
You can add ssh keys to your user in the user set within `machine-settings`. One word of warning, as lists are not overwritten, but merged, this means that if you add a key in the root `common-settings.nix` this key cannot be removed for any specific machine.
