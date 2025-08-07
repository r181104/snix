{ config, pkgs, ... }:

{
  hardware.graphics.enable = true;
  hardware.nvidia = {
    open = false;
    powerManagement.enable = true;
    modesetting.enable = true;
    nvidiaSettings = true;
    prime = {
      intelBusId = "PCI:0:2:0";
      nvidiaBusId = "PCI:1:0:0";
      offload = {
        enable = true;
        enableOffloadCmd = true;
      };
    };
  };
  services.xserver.videoDrivers = [ "intel" ];
  services.thermald.enable = true;
  services.tlp.enable = true;
}
