{
  config,
  pkgs,
  lib,
  ...
}: {
  # hardware.nvidia = {
  #   open = false;
  #   modesetting.enable = true;
  #   nvidiaSettings = true;
  #   prime = {
  #     offload = {
  #       enable = true;
  #       enableOffloadCmd = true;
  #     };
  #     intelBusId = "PCI:0:2:0";
  #     nvidiaBusId = "PCI:1:0:0";
  #   };
  # };

  # boot.extraModulePackages = [pkgs.linuxPackages.nvidia_x11];
  # boot.blacklistedKernelModules = ["nouveau"];

  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      mesa
      mesa-demos
      libGL
      vulkan-loader
      vulkan-tools
      vulkan-validation-layers
    ];
    extraPackages32 = with pkgs.pkgsi686Linux; [
      mesa
      mesa-demos
      libGL
      vulkan-loader
      vulkan-tools
    ];
  };
  environment.systemPackages = with pkgs; [
    vdpauinfo
    vulkan-tools
    vulkan-validation-layers
  ];
}
