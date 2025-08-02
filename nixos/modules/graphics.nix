{ config, pkgs, ... }:

{
  hardware.graphics.enable = true;
  hardware.nvidia.open = true;
  hardware.nvidia.modesetting.enable = true;
  services.xserver.videoDrivers = [ "nvidia" ];
  boot.kernelParams = [ "nomodeset" ];
}
