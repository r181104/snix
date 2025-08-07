{ config, pkgs, lib, ... }:

{
    hardware.nvidia.prime = {
        intelBusId = "PCI:0@0:2:0";
        nvidiaBusId = "PCI:0@1:0:0";
        offload.enable = true;
    };
    hardware.nvidia = {
    open = false;
    nvidiaSettings = true;
    modesetting.enable = true;
    forceFullCompositionPipeline = true;
    };
  boot.extraModulePackages = [ pkgs.linuxPackages.nvidia_x11 ];
  boot.blacklistedKernelModules = [ "nouveau" "nvidia_drm" "nvidia_modeset" "nvidia" ];
  environment.systemPackages = [ pkgs.linuxPackages.nvidia_x11 ];
}
