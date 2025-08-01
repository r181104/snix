{ config, pkgs, lib, ... }:

{
  imports = [ ./hardware-configuration.nix ];

# Use latest kernel from unstable channel
  boot.kernelPackages = pkgs.linuxPackages_latest;

# NVIDIA Hybrid Graphics Configuration (PRIME Render Offload)
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia = {
    modesetting.enable = lib.mkDefault true;
    powerManagement.enable = lib.mkDefault true;
    powerManagement.finegrained = lib.mkDefault false;
    open = lib.mkDefault false;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.beta.overrideAttrs (old: {
        version = "555.42.02";
        src = pkgs.fetchurl {
        url = "https://download.nvidia.com/XFree86/Linux-x86_64/555.42.02/NVIDIA-Linux-x86_64-555.42.02.run";
        sha256 = "sha256-7Qe7lX3v3H2f7WXj6i7k8Y7a0z1d3c4b5d6e7f8g9h0i1j2k3l4m5n6o7p8";
        };
        });

# PRIME configuration - REPLACE WITH YOUR BUS IDs
    prime = {
      offload.enable = true;
# Find bus IDs with: lspci | grep -E "VGA|3D"
      intelBusId = "PCI:0:2:0";    # Example: Intel GPU
        nvidiaBusId = "PCI:1:0:0";   # Example: NVIDIA GPU
    };

# Power management tweaks
    powerManagement.forceEnable = true;
    nvidiaPersistenced = true;
  };

# Intel GPU configuration
  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
    extraPackages = with pkgs; [
      intel-media-driver          # New Intel media driver
        intel-compute-runtime       # For OpenCL support
        vaapiIntel                  # VA-API implementation
        vaapiVdpau                  # VDPAU bridge
        libvdpau-va-gl              # VDPAU driver
    ];
    extraPackages32 = with pkgs.pkgsi686Linux; [
      vaapiIntel
    ];
  };

# Boot Configuration
  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
      timeout = 3;
    };

# Kernel modules for early boot
    initrd.kernelModules = [ 
      "i915"          # Intel graphics
      "nvidia"        # NVIDIA module
      "nvidia_modeset"
      "nvidia_uvm"
      "nvidia_drm"
    ];

# Kernel parameters for hybrid graphics
    kernelParams = [
# NVIDIA power management
      "nvidia.NVreg_DynamicPowerManagement=0x02"
        "nvidia.NVreg_PreserveVideoMemoryAllocations=1"
        "nvidia.NVreg_TemporaryFilePath=/var/tmp/nvidia"

# Intel parameters
        "i915.enable_guc=2"         # Enable GuC/HuC firmware
        "i915.enable_fbc=1"         # Enable frame buffer compression
        "i915.enable_psr=1"         # Enable panel self refresh
    ];

# Blacklist conflicting drivers
    blacklistedKernelModules = [ "nouveau" ];

# Enable NVIDIA DRM kernel mode setting
    kernelModules = [ "nvidia-drm" ];
  };

# Network Configuration
  networking.hostName = "nixos";
  networking.networkmanager.enable = true;
  networking.firewall.enable = true;

# Internationalization
  time.timeZone = "Asia/Kolkata";
  i18n.defaultLocale = "en_IN";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_IN";
    LC_IDENTIFICATION = "en_IN";
    LC_MEASUREMENT = "en_IN";
    LC_MONETARY = "en_IN";
    LC_NAME = "en_IN";
    LC_NUMERIC = "en_IN";
    LC_PAPER = "en_IN";
    LC_TELEPHONE = "en_IN";
    LC_TIME = "en_IN";
  };

# X11 Desktop Environment with Hybrid Graphics Support
  services.xserver = {
    enable = true;
    displayManager.lightdm.enable = true;
    desktopManager.budgie.enable = true;
    videoDrivers = [ "nvidia" ];

# Configure keymap
    xkb.layout = "us";

# NVIDIA-specific X11 settings
    deviceSection = ''
      Option "AllowEmptyInitialConfiguration"
      Option "PrimaryGPU" "no"
      '';

    screenSection = ''
      Option         "metamodes" "nvidia-auto-select +0+0 {ForceFullCompositionPipeline=On}"
      Option         "AllowIndirectGLXProtocol" "off"
      Option         "TripleBuffer" "on"
      '';

# Enable DRM kernel mode setting
    drm = {
      enable = true;
      modeset = {
        enable = true;
        nvidia = true;
      };
    };
  };

  services.libinput.enable = true;

# Sound Configuration (using PipeWire with Intel as default)
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;

# Fix for hybrid audio
    config.pipewire = {
      "context.properties" = {
        "link.max-buffers" = 16;
      };
      "context.modules" = [
      {
        name = "libpipewire-module-rtkit";
        args = {
          "nice.level" = -15;
          "rt.prio" = 88;
          "rt.time.soft" = 200000;
          "rt.time.hard" = 200000;
        };
        flags = [ "ifexists" "nofail" ];
      }
      { name = "libpipewire-module-protocol-native"; }
      { name = "libpipewire-module-client-node"; }
      { name = "libpipewire-module-adapter"; }
      { name = "libpipewire-module-metadata"; }
      ];
    };
  };

# User Configuration
  users.users.hack = {
    isNormalUser = true;
    description = "hack";
    extraGroups = [ 
      "networkmanager" 
      "wheel" 
      "video" 
      "audio" 
      "lp" 
      "scanner" 
      "render"
      "vboxusers"
      "docker"
    ];
    shell = pkgs.zsh;
  };

# System Packages for Unstable Channel
  environment.systemPackages = with pkgs; [
# Hybrid Graphics Utilities
    nvtop
      intel-gpu-tools
      clinfo
      vulkan-tools
      glxinfo
      nvidia-vaapi-driver
      libva-utils

# PRIME Utilities
      (writeShellScriptBin "prime-run" ''
       export __NV_PRIME_RENDER_OFFLOAD=1
       export __NV_PRIME_RENDER_OFFLOAD_PROVIDER=NVIDIA-G0
       export __GLX_VENDOR_LIBRARY_NAME=nvidia
       export __VK_LAYER_NV_optimus=NVIDIA_only
       exec "$@"
       '')

# System Utilities
      powertop
      auto-cpufreq
      tlp

# ... rest of your packages ...
      ];

# Environment variables for hybrid graphics
  environment.sessionVariables = {
# NVIDIA Variables
    __NV_PRIME_RENDER_OFFLOAD = "1";
    __NV_PRIME_RENDER_OFFLOAD_PROVIDER = "NVIDIA-G0";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    GBM_BACKEND = "nvidia-drm";
    __VK_LAYER_NV_optimus = "NVIDIA_only";
    WLR_NO_HARDWARE_CURSORS = "1";
    NVD_BACKEND = "direct";

# Intel VA-API
    LIBVA_DRIVER_NAME = "iHD";
    VDPAU_DRIVER = "va_gl";

# General
    MOZ_DISABLE_RDD_SANDBOX = "1";  # Firefox sandbox fix
      EGL_PLATFORM = "wayland";
  };

# Power management for hybrid systems
  powerManagement = {
    enable = true;
    powertop.enable = true;
    cpuFreqGovernor = "powersave";
  };

  services.auto-cpufreq.enable = true;
  services.auto-cpufreq.settings = {
    battery = {
      governor = "powersave";
      turbo = "never";
    };
    charger = {
      governor = "performance";
      turbo = "auto";
    };
  };

  services.tlp = {
    enable = true;
    settings = {
      CPU_SCALING_GOVERNOR_ON_AC = "performance";
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
      PCIE_ASPM_ON_BAT = "powersupersave";
      RUNTIME_PM_ON_AC = "on";
      RUNTIME_PM_ON_BAT = "auto";
      NVIDIA_DYNAMIC_POWER_MANAGEMENT = "1";
    };
  };

# Special configuration for Budgie with hybrid graphics
  services.xserver.displayManager.sessionCommands = ''
# Fixes tearing in some applications
    export CLUTTER_BACKEND=wayland
    export SDL_VIDEODRIVER=wayland

# NVIDIA PRIME environment variables
    export __NV_PRIME_RENDER_OFFLOAD=1
    export __GLX_VENDOR_LIBRARY_NAME=nvidia
    '';

# Enable necessary services
  services = {
    dbus.enable = true;
    gvfs.enable = true;  # For file manager integration
      udisks2.enable = true;
    upower.enable = true;
    blueman.enable = true;
    printing.enable = true;
    openssh.enable = false;
  };

# Nix Settings for Unstable Channel
  nix = {
    package = pkgs.nixUnstable;
    settings = {
      auto-optimise-store = true;
      experimental-features = [ "nix-command" "flakes" "auto-allocate-uids" ];
      trusted-users = [ "root" "hack" ];
      builders-use-substitutes = true;
# For systems with >8GB RAM
      max-jobs = "auto";
      cores = 0;
    };
    gc = {
      automatic = true;
      dates = "daily";
      options = "--delete-older-than 7d";
    };
# Enable nix-ld for better compatibility
    nixPath = [ "nixpkgs=${pkgs.path}" ];
    ld = {
      enable = true;
      libraries = with pkgs; [
        stdenv.cc.cc
          openssl
          curl
          glib
          util-linux
          libseccomp
          libvirt
      ];
    };
  };

# Security settings
  security = {
    sudo.wheelNeedsPassword = true;
    polkit.enable = true;
    protectKernelImage = true;
    lockKernelModules = false;  # Required for NVIDIA power management
  };

  system.stateVersion = "25.05";  # Unstable channel
}
