> Click [here](https://nixos.wiki/wiki/OneDrive) To the original page.

# OneDrive

OneDrive is Microsoft's cloud file storage service. If you have a OneDrive account, for example from your organization or your Office 365 subscription, NixOS has software to let you sync it to a OneDrive directory your home directory.

## Setup
Toggle the module in  either a common setting, or a machine specific settings file, and rebuild your system.

Then as the user, run the following:

```BASH
onedrive
```

You will be given a login URL, open it in your browser, log in to the appropriate Microsoft account to which your OneDrive account is linked to, and after you are logged in, you get an empty screen. This is good, just copy the URL you are redirected to and paste it back in the terminal.

Then run the following:

```BASH
systemctl --user enable onedrive@onedrive.service
systemctl --user start onedrive@onedrive.service
```

this will enable and start the systemd user service. Note: this makes a symlink that is unmanaged by NixOS. When the onedrive service is updated, be sure to disable and enable the Systemd service again.

Check that the service started successfully and is running:


```BASH
systemctl --user status onedrive@onedrive.service
```

To view the log, run the following:

```BASH
journalctl --user -t onedrive | less
```
## See Also
- [Microsoft OneDrive](https://onedrive.live.com/)
- [OneDrive client for Linux](https://github.com/abraunegg/onedrive)
- [nixpkgs OneDrive client package definition](https://github.com/NixOS/nixpkgs/blob/master/pkgs/applications/networking/sync/onedrive/default.nix)
