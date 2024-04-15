## Defines the networking proxy options.

{ config, pkgs, lib, ... } : { networking.proxy  = {
        # default = "http://user:password@proxy:port/";
        # noProxy = "127.0.0.1,localhost,internal.domain";
    };
}
