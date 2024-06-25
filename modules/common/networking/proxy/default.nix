## Defines the networking proxy options.
 
arguments @ { config, pkgs, lib, machine-settings, ... } : ( builtins.trace "Loading: ${toString ./.}..." { 

    networking.proxy  = {
        # default = (lib.mkDefault "http://user:password@proxy:port/");
        # noProxy = (lib.mkDefault "127.0.0.1,localhost,internal.domain");
    };

})
