## Changes settings to enable nvidia GPU's on this system.
#! Follow the guide PRECIESLY to set your setting variables: https://nixos.wiki/wiki/Nvidia
arguments @ { config, pkgs, lib, machine-settings, ... } : let
 
    module-settings = machine-settings.system.modules.nvidia; 

in ( if module-settings.enable then builtins.trace "Loading: ${toString ./.}... " {

    hardware.nvidia.prime = {
		
        intelBusId  = module-settings.prime.intel;
		nvidiaBusId = module-settings.prime.nvidia;

        offload = ( if ( module-settings.prime.offload == true ) then ({
			
            enable = true;
			enableOffloadCmd = true;

		}) else {} );

	};

    hardware.nvidia = {

        # Optionally, you may need to select the appropriate driver version for your specific GPU.
        package = with config.boot.kernelPackages.nvidiaPackages; (
            if ( module-settings.hardwarePackage == "stable"      ) then ( stable      ) else 
            if ( module-settings.hardwarePackage == "beta"        ) then ( beta        ) else 
            if ( module-settings.hardwarePackage == "production"  ) then ( production  ) else 
            if ( module-settings.hardwarePackage == "vulkan_beta" ) then ( vulkan_beta ) else 
            if ( module-settings.hardwarePackage == "legacy_470"  ) then ( legacy_470  ) else 
            if ( module-settings.hardwarePackage == "legacy_390"  ) then ( legacy_390  ) else 
            if ( module-settings.hardwarePackage == "legacy_340"  ) then ( legacy_340  ) else 
            abort "The hardware package \"${module-settings.hardwarePackage}\" is not one of the options."
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

} else {} )