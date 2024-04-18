## Defines the networking proxy options.
 
arguments @ { config, pkgs, lib, machine-settings, ... } : let 
    
    _ = builtins.trace "Loading: /modules/common/networking/proxy..." machine-settings; 

in { networking.proxy  = {
        # default = "http://user:password@proxy:port/";
        # noProxy = "127.0.0.1,localhost,internal.domain";
    };
}
