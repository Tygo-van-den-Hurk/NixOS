## This module enables some powersaving configurations

arguments @ { config, pkgs, lib, machine-settings, ... } : let 

    #! make sure that the variable that `builtins.trace` assigns get used to trigger the print.
    #` this is because `builtins.trace` only prints a trace on the output if the variable gets used.
    #` that's why you have to go through hoops and bounds to get this variable used so that it prints the message.
    module-settings = (builtins.trace "Loading: ${toString ./.}..." machine-settings.system.modules.power-efficiency); 

in ( if module-settings.enable == true then {

    services.tlp = {
        enable = true;
        settings = {

            CPU_SCALING_GOVERNOR_ON_AC = "performance";
            CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

            CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
            CPU_ENERGY_PERF_POLICY_ON_AC = "performance";

            CPU_MIN_PERF_ON_AC = 0;
            CPU_MAX_PERF_ON_AC = 100;
            CPU_MIN_PERF_ON_BAT = 0;
            CPU_MAX_PERF_ON_BAT = 20;

            #Optional helps save long term battery health
            # START_CHARGE_THRESH_BAT0 = 40; # 40 and bellow it starts to charge
            # STOP_CHARGE_THRESH_BAT0 = 80; # 80 and above it stops charging
        };
    };

} else {} )
