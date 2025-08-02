{ config, pkgs, ... }:

{
  hardware.graphics = {
    enable = true;
  };
  hardware.nvidia = {
    open = false;
    powerManagement.enable = true;
    modesetting.enable = true;
    nvidiaSettings = true;
  };
  hardware.nvidia.prime = {
    offload.enable = true;
    intelBusId = "PCI:0:2:0";
    nvidiaBusId = "PCI:1:0:0";
  };
  services.xserver.videoDrivers = [ "intel" "nvidia" ];
  services.thermald.enable = true;
  services.tlp.enable = true;
  boot.kernelParams = [ "nomodeset" ];
}
