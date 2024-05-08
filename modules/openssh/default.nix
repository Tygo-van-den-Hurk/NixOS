## Defines the SSH service that runs on the system.

arguments @ { config, pkgs, lib, machine-settings, ... } : let 
    
    #! make sure that the variable that `builtins.trace` assigns get used to trigger the print.
    #` this is because `builtins.trace` only prints a trace on the output if the variable gets used.
    #` that's why you have to go through hoops and bounds to get this variable used so that it prints the message.
    yes = builtins.trace ("Loading: /modules/openssh...") (true); 

in { services.openssh = {
        
        enable = yes;

        settings = { # Enhance Security
            PasswordAuthentication = false;
            KbdInteractiveAuthentication = false;
            openssh.settings.PermitRootLogin = "no";
        };

        #! WARNING, these SSH key's are allowed to log into your machines. 
        #` There should only be 1 per host. This is because the SSH keys this immedately breaks the old outdated key.
        #` Remove any keys that you do not reconise! You can get this string by going to:
        #`
        #      ~/.ssh/<Your Machine's HostName>/
        #`
        #` and then getting the contents of the '.pub' file. You can paste that raw in here.
        #` Do not put the private key (the one without the '.pub' extention) in here!
        users.users.${machine-settings.user.username}.openssh.authorizedKeys.keys = [
            "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHvSu8xkYJQX2br3EHxNADY7byEzRAXlc+Z8X+vbwuRd tygo@tygos-thinkpad"
        ];

    };
}
