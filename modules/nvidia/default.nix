## Changes settings to enable nvidia GPU's on this system.
#! Follow the guide PRECIESLY to set your setting variables: https://nixos.wiki/wiki/Nvidia
arguments @ { config, pkgs, lib, machine-settings, ... } : let 

    __nvidia_ = machine-settings.modules.nvidia;

    #! make sure that the variable that `builtins.trace` assigns get used to trigger the print.
    #` this is because `builtins.trace` only prints a trace on the output if the variable gets used.
    #` that's why you have to go through hoops and bounds to get this variable used so that it prints the message.
    nvidia = builtins.trace ("Loading: /modules/nvidia... (NVIDIA hardware package: ${__nvidia_.hardwarePackage})") (
        __nvidia_
    ); 

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ DOCUMENTATION ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#

# This is an example of some settings for the NVIDIA module:
example = {

    # whether to enable this module
    # no things needed
    enable = true;

    # Out of the above, `stable` and `beta` will work for the latest RTX cards and some lower cards so long as 
    # they're not considered "legacy" by Nvidia. For "legacy" cards, you can consult the Nvidia official legacy 
    # driver list and check whether your device is supported by the 470, 390 or 340 branches. If so, you can use 
    # the corresponding legacy_470, legacy_390 or legacy_340 driver. For a full list of options, consult the 
    # nvidia-x11 module repository. 
    #
    # links are: 
    #
    #  - The Nvidia official legacy driver list:    
    #    https://www.nvidia.com/en-us/drivers/unix/legacy-gpu/
    #
    #  - The nvidia-x11 module repository:
    #    https://github.com/NixOS/nixpkgs/blob/nixos-unstable/pkgs/os-specific/linux/nvidia-x11/default.nix
    #
    # Options are: "stable", "beta", "production", "vulkan_beta", "legacy_470", "legacy_390", "legacy_340".
    hardwarePackage = "stable";

    # Nvidia Optimus PRIME is a technology developed by Nvidia to optimize the power consumption and performance 
    # of laptops equipped with their GPUs. It seamlessly switches between the integrated graphics, usually from 
    # Intel, for lightweight tasks to save power, and the discrete Nvidia GPU for performance-intensive tasks 
    # like gaming or video editing. By dynamically balancing graphics power and battery life, Optimus provides 
    # the best of both worlds, ensuring that users get longer battery life without sacrificing graphical 
    # performance. 
    prime = {
        
        # Wether to enable it.
        enable = true;

        # run  `sudo lshw -c display` to figure out these values:
        #
        # "driver=nouveau" --> NVIDIA
        # "driver=i915"    --> Intel
        #
        #! WATCH OUT, THE VALUES FROM 'lshw' ARE IN HEXADECIMAL. CONVERT THEM!!!
        nvidia = "PCI:1:0:0";
        intel  = "PCI:0:2:0";

        # Offload Mode is available in NixOS 20.09 and higher, and requires an Nvidia card of the Turing 
        # generation or newer, and an Intel chipset from the Coffee Lake generation or newer.
        #
        # Offload mode puts your Nvidia GPU to sleep and lets the Intel GPU handle all tasks, except if you call 
        # the Nvidia GPU specifically by "offloading" an application to it. For example, you can run your laptop
        # normally and it will use the energy-efficient Intel GPU all day, and then you can offload a game from 
        # Steam onto the Nvidia GPU to make the Nvidia GPU run that game only. For many, this is the most 
        # desirable option. 
        offload = true;

    };
};

in

#! you CANNOT load this module without enabling unfree software !#
assert ( machine-settings.system.packages.allowUnfree == true );
#! you CANNOT load this module without enabling unfree software !#

assert ( #! hardwarePackage must be specified
    (machine-settings.modules.nvidia.hardwarePackage != null) 
    && (machine-settings.modules.nvidia.hardwarePackage != false) 
    && (machine-settings.modules.nvidia.hardwarePackage != "") 
);

assert ( #! prime must be specified
    (machine-settings.modules.nvidia.prime != null) 
    && (machine-settings.modules.nvidia.prime != false) 
    && (machine-settings.modules.nvidia.prime != "") 
);

assert ( #! prime nvidia must be specified
    (machine-settings.modules.nvidia.prime.nvidia != null) 
    && (machine-settings.modules.nvidia.prime.nvidia != false) 
    && (machine-settings.modules.nvidia.prime.nvidia != "") 
);

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ CONFIGURATION ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
{

    hardware.nvidia.prime = {
		
        intelBusId  = nvidia.prime.intel;
		nvidiaBusId = nvidia.prime.nvidia;

        offload = ( if ( nvidia.prime.offload == true ) then ({
			
            enable = true;
			enableOffloadCmd = true;

		}) else {} );

	};

    hardware.nvidia = {

        # Optionally, you may need to select the appropriate driver version for your specific GPU.
        package = ( # TODO try adding `with config.boot.kernelPackages.nvidiaPackages;` to shorten the names below.
            if ( nvidia.hardwarePackage == "stable"      ) then ( config.boot.kernelPackages.nvidiaPackages.stable      ) else 
            if ( nvidia.hardwarePackage == "beta"        ) then ( config.boot.kernelPackages.nvidiaPackages.beta        ) else 
            if ( nvidia.hardwarePackage == "production"  ) then ( config.boot.kernelPackages.nvidiaPackages.production  ) else 
            if ( nvidia.hardwarePackage == "vulkan_beta" ) then ( config.boot.kernelPackages.nvidiaPackages.vulkan_beta ) else 
            if ( nvidia.hardwarePackage == "legacy_470"  ) then ( config.boot.kernelPackages.nvidiaPackages.legacy_470  ) else 
            if ( nvidia.hardwarePackage == "legacy_390"  ) then ( config.boot.kernelPackages.nvidiaPackages.legacy_390  ) else 
            if ( nvidia.hardwarePackage == "legacy_340"  ) then ( config.boot.kernelPackages.nvidiaPackages.legacy_340  ) else 
            abort "The hardware package \"${nvidia.hardwarePackage}\" is not one of the options."
        );

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ DEFAULT ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#

        # Modesetting is required.
        modesetting.enable = true;

        # Nvidia power management. Experimental, and can cause sleep/suspend to fail.
        # Enable this if you have graphical corruption issues or application crashes after waking
        # up from sleep. This fixes it by saving the entire VRAM memory to /tmp/ instead 
        # of just the bare essentials.
        powerManagement.enable = false;

        # Fine-grained power management. Turns off GPU when not in use.
        # Experimental and only works on modern Nvidia GPUs (Turing or newer).
        powerManagement.finegrained = false;

        # Use the NVidia open source kernel module (not to be confused with the
        # independent third-party "nouveau" open source driver).
        # Support is limited to the Turing and later architectures. Full list of 
        # supported GPUs is at: 
        # https://github.com/NVIDIA/open-gpu-kernel-modules#compatible-gpus 
        # Only available from driver 515.43.04+
        # Currently alpha-quality/buggy, so false is currently the recommended setting.
        open = false;

        # Enable the Nvidia settings menu,
        # accessible via `nvidia-settings`.
        nvidiaSettings = true;
    };

    # Enable OpenGL
    hardware.opengl = {
        enable = true;
        driSupport = true;
        driSupport32Bit = true;
    };

    # Load nvidia driver for Xorg and Wayland
    services.xserver.videoDrivers = [ "nvidia" ];

}
