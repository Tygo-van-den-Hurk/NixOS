## Defines the services that run on the system.

arguments @ { config, pkgs, lib, machine-settings, ... } : let 
    
    #! make sure that the variable that `builtins.trace` assigns get used to trigger the print.
    #` this is because `builtins.trace` only prints a trace on the output if the variable gets used.
    #` that's why you have to go through hoops and bounds to get this variable used so that it prints the message.
    options = (builtins.trace "Loading: /modules/common/services/logind..." {
        ignore = "ignore";
        poweroff = "poweroff";
        reboot = "reboot";
        halt = "halt";
        kexec = "kexec";
        suspend = "suspend";
        hibernate = "hibernate";
        hybrid-sleep = "hybrid-sleep";
        suspend-then-hibernate = "suspend-then-hibernate";
        lock = "lock";
    });

in { services.logind = {

        #!  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        #!  %                                            %
        #!  %  This does not actually do something yet!  %
        #!  %                                            %
        #!  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        #!
        #! This is because logind isn't running yet. I don't know why,
        #! or how to enable it yet. 
        #!

        lidSwitchDocked         = options.ignore;  # laptop lid is closed and another screen is added.
        lidSwitchExternalPower  = options.ignore;  # laptop lid is closed and the system is on external power.
        lidSwitch               = options.suspend; # laptop lid is closed

    };
}
