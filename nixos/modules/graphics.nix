{
  config,
  pkgs,
  lib,
  ...
}: {
  # NVIDIA + Intel Hybrid GPU Setup
  hardware.nvidia = {
    open = false;
    modesetting.enable = true;
    nvidiaSettings = true;
    forceFullCompositionPipeline = true;
    prime = {
      offload.enable = true;
      intelBusId = "PCI:0:2:0"; # adjust with `lspci | grep VGA`
      nvidiaBusId = "PCI:1:0:0"; # adjust with `lspci | grep VGA`
    };
  };

  # Kernel Module & Blacklist
  boot.extraModulePackages = [pkgs.linuxPackages.nvidia_x11];
  boot.blacklistedKernelModules = ["nouveau"];

  # OpenGL / Vulkan
  hardware.opengl = {
    enable = true;
    extraPackages = with pkgs; [
      mesa
      mesa_drivers
      libGL
      vulkan-loader
      vulkan-tools
      vulkan-validation-layers
    ];
    extraPackages32 = with pkgs.pkgsi686Linux; [
      mesa
      libGL
      vulkan-loader
      vulkan-tools
    ];
  };

  # System Packages (GPU tools)
  environment.systemPackages = with pkgs; [
    nvidia_x11
    nvidia-settings
    vdpauinfo
    vulkan-tools
    vulkan-validation-layers
  ];
}
