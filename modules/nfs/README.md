# NFS
This is where I configure my NFS shares. This is what this module's config should look like:

```NIX
machine-settings.modules = {

    nfs = {
        server1 = [ "some-share" "another-share" ];
        server2 = [ "last-share" ];
    };

}
```

