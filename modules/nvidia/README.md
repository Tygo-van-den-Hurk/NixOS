[Original Page](https://nixos.wiki/wiki/Nvidia)

# Installing Nvidia Drivers on NixOS
NixOS uses a functional package management approach, which necessitates specific procedures for driver installation. When considering NVIDIA GPU drivers in a Linux environment, the installation process can be more complex compared to AMD and Intel. This complexity arises primarily because NVIDIA's official drivers are closed source and not typically bundled with many distributions. This document outlines the technical steps required to install NVIDIA GPU drivers on NixOS, factoring in both the unique nature of NixOS and the proprietary status of NVIDIA's drivers.

## Enable Unfree Software Repositories
Make sure to allow Unfree Software. The unfree NVIDIA packages include `nvidia-x11`, `nvidia-settings`, and `nvidia-persistenced`.


## Determining the Correct Driver Version
You will next need to determine the appropriate driver version for your card. The following options are available:
```NIX
hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.stable;
hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.beta;
hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.production;  # (installs 550)
hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.vulkan_beta;
hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.legacy_470;
hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.legacy_390;
hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.legacy_340;
```

Out of the above, `stable` and `beta` will work for the latest RTX cards and some lower cards so long as they're not considered "legacy" by Nvidia. For "legacy" cards, you can consult the [Nvidia official legacy driver list](https://www.nvidia.com/en-us/drivers/unix/legacy-gpu/) and check whether your device is supported by the 470, 390 or 340 branches. If so, you can use the corresponding `legacy_470`, `legacy_390` or `legacy_340` driver. For a full list of options, consult the [nvidia-x11 module repository](https://github.com/NixOS/nixpkgs/blob/nixos-unstable/pkgs/os-specific/linux/nvidia-x11/default.nix).

> [!NOTE]
> As of early March 2024 the `production` driver has been updated from `535` to `550`. This is a breaking change for some people, especially those on Wayland. To resolve this follow the steps under [Running the new RTX SUPER on nixos stable](https://nixos.wiki/wiki/Nvidia#Running_the_new_RTX_SUPER_on_nixos_stable).

Once you've determined the correct driver version, note it down; you'll need it in the next step.

## Modifying NixOS Configuration
Ensure that the following is in your NixOS configuration file (customizing as you prefer):

> [!WARNING]
> If you are using a laptop, the below configuration update is not sufficient to get your Nvidia card running! Once you've entered it, please continue reading, as there are important adjustments that must then be made to the configuration before your laptop graphics will work properly.

```NIX
{ config, lib, pkgs, ... } : {

  # Enable OpenGL
  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };

  # Load nvidia driver for Xorg and Wayland
  services.xserver.videoDrivers = ["nvidia"];

  hardware.nvidia = {

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

    # Optionally, you may need to select the appropriate driver version for your specific GPU.
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };
  ...
}
```

## Laptop Configuration: Hybrid Graphics (Nvidia Optimus PRIME)
In order to correctly finish configuring your Nvidia graphics driver, you must follow the below steps, which differ depending on whether or not you are using a hybrid graphics setup or not. A laptop with hybrid graphics possesses both an integrated GPU (often from the central processor) and a discrete, more powerful Nvidia GPU, typically for performance-intensive tasks. This dual-GPU setup allows for power-saving during basic tasks and higher graphics performance when needed.

**Nvidia Optimus PRIME** is a technology developed by Nvidia to optimize the power consumption and performance of laptops equipped with their GPUs. It seamlessly switches between the integrated graphics, usually from Intel, for lightweight tasks to save power, and the discrete Nvidia GPU for performance-intensive tasks like gaming or video editing. By dynamically balancing graphics power and battery life, Optimus provides the best of both worlds, ensuring that users get longer battery life without sacrificing graphical performance.

### Configuring Optimus PRIME: Bus ID Values (Mandatory)
Before we can continue, we must mandatorily first determine the Bus ID values for both your Nvidia and Intel GPUs. This step will be essential regardless of which configuration you later adopt.

First, install the `lshw` package in order to be able to use the `lshw` command, then run:
```BASH
sudo lshw -c display
```

You will likely get something like this:
```
*-display                 
description: i915drmfb
physical id: 0
bus info: pci@0000:0e:00.0
logical name: /dev/fb0
version: a1
width: 64 bits
clock: 33MHz
capabilities: pm msi pciexpress bus_master cap_list rom fb
configuration: depth=32 driver=nvidia latency=0 mode=2560x1600 visual=truecolor xres=2560 yres=1600
resources: iomemory:600-5ff iomemory:620-61f irq:220 memory:85000000-85ffffff memory:6000000000-61ffffffff memory:6200000000-6201ffffff ioport:5000(size=128) memory:86000000-8607ffff

*-display
product: i915drmfb
physical id: 2
bus info: pci@0000:00:02.0
logical name: /dev/fb0
version: 04
width: 64 bits
clock: 33MHz
capabilities: pciexpress msi pm bus_master cap_list rom fb
configuration: depth=32 driver=i915 latency=0 resolution=2560,1600
resources: iomemory:620-61f iomemory:400-3ff irq:221 memory:622e000000-622effffff memory:4000000000-400fffffff ioport:6000(size=64) memory:c0000-dffff memory:4010000000-4016ffffff memory:4020000000-40ffffffff
```

Note the two values under "bus info" above, which may differ from laptop to laptop. Our Nvidia Bus ID is `0e:00.0` and our Intel Bus ID is `00:02.0`. Watch out for the formatting; convert them from hexadecimal to decimal, remove the padding (leading zeroes), replace the dot with a colon, then add them like this:

```NIX
{
	hardware.nvidia.prime = {
		# Make sure to use the correct Bus ID values for your system!
		intelBusId = "PCI:0:2:0";
		nvidiaBusId = "PCI:14:0:0";
	};
}
```

### Optimus PRIME Option A: Offload Mode
Offload Mode is available in NixOS 20.09 and higher, and requires an Nvidia card of the Turing generation or newer, and an Intel chipset from the Coffee Lake generation or newer.

Offload mode puts your Nvidia GPU to sleep and lets the Intel GPU handle all tasks, except if you call the Nvidia GPU specifically by "offloading" an application to it. For example, you can run your laptop normally and it will use the energy-efficient Intel GPU all day, and then you can offload a game from Steam onto the Nvidia GPU to make the Nvidia GPU run that game only. For many, this is the most desirable option.

Offload mode is enabled by running your programs with specific environment variables. Here's a sample script called `nvidia-offload` that you can run wrapped around your executable, for example `nvidia-offload glxgears`:
```
export __NV_PRIME_RENDER_OFFLOAD=1
export __NV_PRIME_RENDER_OFFLOAD_PROVIDER=NVIDIA-G0
export __GLX_VENDOR_LIBRARY_NAME=nvidia
export __VK_LAYER_NV_optimus=NVIDIA_only
exec "$@"
```

To enable offload mode, finish configuring your Nvidia driver by adding the following to your NixOS configuration file:
```NIX
{
	hardware.nvidia.prime = {
		offload = {
			enable = true;
			enableOffloadCmd = true;
		};
		# Make sure to use the correct Bus ID values for your system!
		intelBusId = "PCI:0:2:0";
		nvidiaBusId = "PCI:14:0:0";
	};
}
```

### Optimus PRIME Option B: Sync Mode

Enabling PRIME sync introduces better performance and greatly reduces screen tearing, at the expense of higher power consumption since the Nvidia GPU will not go to sleep completely unless called for, as is the case in Offload Mode. It may also cause its own issues in rare cases. **PRIME Sync and Offload Mode cannot be enabled at the same time**.

PRIME sync may also solve some issues with connecting a display in clamshell mode directly to the GPU.

```NIX
{
  hardware.nvidia.prime = {
    sync.enable = true;

    # Make sure to use the correct Bus ID values for your system!
    nvidiaBusId = "PCI:14:0:0";
    intelBusId = "PCI:0:2:0";
  };
}
```

### Optimus Option C: Reverse Sync Mode (Experimental)
This feature is relatively new and may not work properly on all systems (see discussion). It is also only available on driver 460.39 or newer. Reverse sync also only works with services.xserver.displayManager.setupCommands compatible Display Managers (LightDM, GDM and SDDM).
```NIX
{
  hardware.nvidia.prime = {
    reverseSync.enable = true;
    # Enable if using an external GPU
    allowExternalGpu = false;

    # Make sure to use the correct Bus ID values for your system!
    intelBusId = "PCI:0:2:0";
    nvidiaBusId = "PCI:14:0:0";
  };
}
```

## Useful Tips

### Check NixosHardware
You should check the nixoshardware GitHub repository. It is possible that someone already wrote a hardware configuration for your device and that usually takes care of drivers. If so, follow the upstream documentation to enable the required modules.

### Multiple Boot Configurations
Imagine you have a laptop that you mostly use in clamshell mode (docked, connected to an external display and plugged into a charger) but that you sometimes use on the go.

In clamshell mode, using PRIME Sync is likely to lead to better performance, external display support, etc., at the cost of potentially (but not always) lower battery life. However, when using the laptop on the go, you may prefer to use offload mode.

NixOS supports "specialisations", which allow you to automatically generate different boot profiles when rebuilding your system. We can, for example, enable PRIME sync by default, but also create a "on-the-go" specialization that disables PRIME sync and instead enables offload mode:
```NIX
{
    specialisation = {
        on-the-go.configuration = {
            system.nixos.tags = [ "on-the-go" ];
            hardware.nvidia = {
                prime.offload.enable = lib.mkForce true;
                prime.offload.enableOffloadCmd = lib.mkForce true;
                prime.sync.enable = lib.mkForce false;
            };
        };
    };
}
```


(You can also add other settings here totally unrelated to Nvidia, such as power profiles, etc.)

After rebuilding and rebooting, you'll see in your boot menu under each Generation an "on-the-go" option, which will let you boot into the on-to-go specialisation for that generation.

### Using GPUs on non-NixOS

If you're using Nix-packaged software on a non-NixOS system, you'll need a workaround to get everything up-and-running. The [nixGL](https://github.com/guibou/nixGL) project provides wrapper to use GL drivers on non-NixOS systems. You need to have GPU drivers installed on your distro (for kernel modules). With nixGL installed, you'll run `nixGL foobar` instead of `foobar`.

Note that nixGL is not specific to Nvidia GPUs, and should work with just about any GPU.

### CUDA and using your GPU for compute
See the [CUDA](https://nixos.wiki/wiki/CUDA) wiki page.

### Using Steam in Offload Mode
In order to automatically launch Steam in offload mode, you need to add the following to your `~/.bashrc`:

```BASH
export XDG_DATA_HOME="$HOME/.local/share"
```

Then, if you are using NixOS Steam, run:

```BASH
mkdir -p ~/.local/share/applications
sed 's/^Exec=/&nvidia-offload /' /run/current-system/sw/share/applications/steam.desktop > ~/.local/share/applications/steam.desktop
```

For Flatpak Steam, run:

```BASH
mkdir -p ~/.local/share/applications
sed 's/^Exec=/&nvidia-offload /' /var/lib/flatpak/exports/share/applications/com.valvesoftware.Steam.desktop > ~/.local/share/applications/com.valvesoftware.steam.desktop
```
Then restart your graphical environment session (or simply reboot).

### Running the new RTX SUPER on nixos stable
The new RTX Super are not supported by the 545 driver. On Nixos stable, you want to use the 535 driver that come from unstable branch or the 550 (beta). To do that you need to manually call the driver you want in your config. Check on this link to choose the driver you want and change your config accordingly : [https://github.com/NixOS/nixpkgs/blob/979a311fbd179b86200e412a3ed266b64808df4e/pkgs/os-specific/linux/nvidia-x11/default.nix#L36](https://github.com/NixOS/nixpkgs/blob/979a311fbd179b86200e412a3ed266b64808df4e/pkgs/os-specific/linux/nvidia-x11/default.nix#L36)

```NIX
{ pkgs, config, libs, ... } : {

    # Enable OpenGL
    hardware.opengl = {
        enable = true;
        driSupport = true;
        driSupport32Bit = true;
    };

    # Load nvidia driver for Xorg and Wayland
    services.xserver.videoDrivers = ["nvidia"];
    
    hardware.nvidia.modesetting.enable = true;
    hardware.nvidia.powerManagement.enable = false;
    hardware.nvidia.powerManagement.finegrained = false;
    hardware.nvidia.open = false;
    hardware.nvidia.nvidiaSettings = true;
    
    # Special config to load the latest (535 or 550) driver for the support of the 4070 SUPER
    hardware.nvidia.package = let 
    rcu_patch = pkgs.fetchpatch {
        url = "https://github.com/gentoo/gentoo/raw/c64caf53/x11-drivers/nvidia-drivers/files/nvidia-drivers-470.223.02-gpl-pfn_valid.patch";
        hash = "sha256-eZiQQp2S/asE7MfGvfe6dA/kdCvek9SYa/FFGp24dVg=";
    };

    in config.boot.kernelPackages.nvidiaPackages.mkDriver {
        version = "535.154.05";
        sha256_64bit = "sha256-fpUGXKprgt6SYRDxSCemGXLrEsIA6GOinp+0eGbqqJg=";
        sha256_aarch64 = "sha256-G0/GiObf/BZMkzzET8HQjdIcvCSqB1uhsinro2HLK9k=";
        openSha256 = "sha256-wvRdHguGLxS0mR06P5Qi++pDJBCF8pJ8hr4T8O6TJIo=";
        settingsSha256 = "sha256-9wqoDEWY4I7weWW05F4igj1Gj9wjHsREFMztfEmqm10=";
        persistencedSha256 = "sha256-d0Q3Lk80JqkS1B54Mahu2yY/WocOqFFbZVBh+ToGhaE=";

        #version = "550.40.07";
        #sha256_64bit = "sha256-KYk2xye37v7ZW7h+uNJM/u8fNf7KyGTZjiaU03dJpK0=";
        #sha256_aarch64 = "sha256-AV7KgRXYaQGBFl7zuRcfnTGr8rS5n13nGUIe3mJTXb4=";
        #openSha256 = "sha256-mRUTEWVsbjq+psVe+kAT6MjyZuLkG2yRDxCMvDJRL1I=";
        #settingsSha256 = "sha256-c30AQa4g4a1EHmaEu1yc05oqY01y+IusbBuq+P6rMCs=";
        #persistencedSha256 = "sha256-11tLSY8uUIl4X/roNnxf5yS2PQvHvoNjnd2CB67e870=";

        patches = [ rcu_patch ];
    };
}
```

## Troubleshooting

### Booting to Text Mode

If you encounter the problem of booting to text mode you might try adding the Nvidia kernel module manually with:

boot.initrd.kernelModules = [ "nvidia" ];
boot.extraModulePackages = [ config.boot.kernelPackages.nvidia_x11 ];

### Screen Tearing Issues
First, try to switch to PRIME Sync Mode, as described above. If that doesn't work, try forcing a composition pipeline.

> [!NOTE]
> Forcing a full composition pipeline has been reported to reduce the performance of some OpenGL applications and may produce issues in WebGL. It also drastically increases the time the driver needs to clock down after load.

```NIX
hardware.nvidia.forceFullCompositionPipeline = true;
```

### Flickering Issues with Picom
```conf
unredir-if-possible = false;
backend = "xrender"; # try "glx" if xrender doesn't help
vsync = true;
```

### Graphical Corruption and System Crashes on Suspend/Resume
```NIX
powerManagement.enable = true # can sometimes fix this, but is itself unstable and is known to cause suspend issues.
```
If you have a modern Nvidia GPU ([Turing or late](https://en.wikipedia.org/wiki/Turing_(microarchitecture)#Products_using_Turing)r), you may also want to investigate the hardware.nvidia.powerManagement.finegrained option: [2]

### Black Screen or Nothing Works on Laptops
The kernel module i915 for intel or amdgpu for AMD may interfere with the Nvidia driver. This may result in a black screen when switching to the virtual terminal, or when exiting the X session. A possible workaround is to disable the integrated GPU by blacklisting the module, using the following configuration option (see also [3]):
```NIX
# intel
boot.kernelParams = [ "module_blacklist=i915" ];
# AMD
boot.kernelParams = [ "module_blacklist=amdgpu" ];
```

## Disable Nvidia dGPU completely
completely disable dGPU, saving battery. Probably not all configurations and module blacklists are required but this worked successfully
```NIX
boot.extraModprobeConfig = ''
  blacklist nouveau
  options nouveau modeset=0
'';

services.udev.extraRules = ''
  # Remove NVIDIA USB xHCI Host Controller devices, if present
  ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x0c0330", ATTR{power/control}="auto", ATTR{remove}="1"
  # Remove NVIDIA USB Type-C UCSI devices, if present
  ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x0c8000", ATTR{power/control}="auto", ATTR{remove}="1"
  # Remove NVIDIA Audio devices, if present
  ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x040300", ATTR{power/control}="auto", ATTR{remove}="1"
  # Remove NVIDIA VGA/3D controller devices
  ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x03[0-9]*", ATTR{power/control}="auto", ATTR{remove}="1"
'';
boot.blacklistedKernelModules = [ "nouveau" "nvidia" "nvidia_drm" "nvidia_modeset" ];
```