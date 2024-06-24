# NFS
This is where I configure my NFS shares. This is what this module's config should look like:

## Settings
This is what the options look like you can add to your machine-settings:
```NIX
{
    machine-settings.users.${user}.init.modules.nfs = {
        enable = boolean;
        servers = {
            "server1.com" = {
                enable = boolean;
                shares = {
                    "some-share" = {
                        enable         = boolean;
                        mount-location = string; # has to be a path   
                        auto-unmount   = string;    
                        lazy-mount     = boolean;
                    };
                };
            };
        };
    }; 
}
```
