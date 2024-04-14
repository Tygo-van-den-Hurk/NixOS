# Common modules
This directory contains all the `.nix` files that configure basic system functions, like networking, services, or users.

The way to use this is by importing these modules. You have two options, you can either import them individually, or all at once. Those options look like this respectively: 

```NIX
# You can import all of them one at a time:
imports = [ 
    .../system/modules/common/bootloader.nix
    .../system/modules/common/miscellaneous.nix
    .../system/modules/common/networking.nix
    .../system/modules/common/packages.nix
    .../system/modules/common/services.nix
    .../system/modules/common/timezone.nix
    .../system/modules/common/user.nix
    # more may get added as the repository changes...
];

# or, you can import all of them:
imports = [
    .../system/modules/common/all.nix
];
```

loading them individually is not recommended as all are required, and this leaves more links to break.

