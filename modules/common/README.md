# Common modules
This directory contains all the settings that should be applied to all systems. If only one system needs to change a settings, that that should be written down inside that hosts configuration, and if multiple systems need that setting, then it should be created as module that can then be loaded by all systems who need it.


## How to use
You can use the module like this:

```NIX
# You can import all of the setting at once by writing:
imports = [ 
    # previous imports...
    ...path/to/modules/common
    #                  ^^^^^^
    #             You are here now.
    ...path/to/modules/someOtherModule
    # other imports...
];
```

By importing the module like this, you know for sure that all of the settings that change immediately get applied to all other systems. 

## Modules structure
This module is structured in such a way that it follows the NixOS attribute flow. That means that if a setting is called: `some.setting.option` you can find it under: `./some/setting/default.nix` starting from this directory. So for example: `boot.loader.grub.enable` can be found in: `./boot/loader/grub/default.nix`. As can any other `boot.loader.grub` setting.

## How it works
if you import this directory, nix will look for a `default.nix` and that file will recursively import all the folders that are present so this is how to import spreads. So as a demonstration some configuration imports common, and common imports:
```TXT
 -- common/
    |                   
    |-- boot/           
    |-- environment/   
    | ...
    
```
And all the subdirectories in this directory. However boot imports loader, which in turn imports efi, grub, and systemd-boot... etc. etc. 
```TXT
 -- boot/
    |-- loader/     
    |       |-- efi/    
    |       |-- grub/   
    |       |-- systemd-boot/ 
    |       |...
    |...
```

## Updating this module
All settings should be written as if they are ment for this module:

```NIX
#` Description of what this attribute set configures
#! a warning for this module telling you to be careful with something
{ pkgs, lib, ...} : { some.setting = {
        #             ^^^^^^^^^^^^
        #     This indirectly shows the 
        #     path as is explained above 
        #     this must be in:   
        #
        #     ...some/path/to/modules/common/some/setting/default.nix
        #                             ^^^^^^
        #                      You are currently here.
        #
        option = lib.mkDefault "the value";
        #         ^^^^^^^^^^^^^
        #    Every setting should be a 
        #    default so that they can be
        #          overwritten
    };
    #
    # After all those settings the file will import all the subdirectories.
    imports = [
        ./someDeeperSetting
        # ^^^^^^^^^^^^^^^^^^^
        # This shows that there must be a subdirectory called 'someDeeperSetting'.
        ./someOtherDeeperSetting
        # ^^^^^^^^^^^^^^^^^^^^^^
        # This shows that there must be a subdirectory called 'someOtherDeeperSetting'.
    ];
}
```

That is because then this way, any other module can override this setting as is needed. This is how lib.mkDefault works:
```NIX
mkOverride = priority: content:
{ _type = "override";
    inherit priority content;
};

## Where this is the values that they have:

# used in config sections of non-user 
mkOptionDefault = mkOverride 1500;

# modules to set a default
mkDefault = mkOverride 1000;  

# image media profiles can be derived by inclusion into host config, hence needing to override host config, but do allow user to mkForce
mkImageMediaOverride = mkOverride 60;

# if you want to a setting to get through
mkForce = mkOverride 50;

# if a setting must (almost) not be able to be overwritten
mkVMOverride = mkOverride 10; # used by ‘nixos-rebuild build-vm’
```

More information can be found [here](https://nixos-and-flakes.thiscute.world/nixos-with-flakes/modularize-the-configuration).

### Adding a setting
if you want to add some setting, for example `foo.bar.option` with value `"some value"`. The you must first navigate to `./foo/bar/default.nix` if this file does not exist in this path, you must created it. You can past this template in 

```NIX
#` Description of what this attribute set configures
#! a warning for this module telling you to be careful with something if needed...
{ pkgs, lib, ...} : { foo.bar = {
        option = lib.mkDefault "some value";
    };

    # FIXME : If there are any subdirectories in this module, make sure they are imported here.
    # imports = [
    #    ./someSubDirectory
    # ];
}
```

If this file did exist you can add the setting in that file as usual.
