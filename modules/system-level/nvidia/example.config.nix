# This is an example of some settings for the NVIDIA module:
#! follow the guide on the NixOS website and read the source code!!
{
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
}