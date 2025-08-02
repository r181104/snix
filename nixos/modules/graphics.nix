{ config, pkgs, ... }:

{
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.opengl.enable = true;
  hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.stable;
  hardware.opengl.driSupport32Bit = true;
  hardware.nvidia.driSupport32Bit = true;
  hardware.nvidia.cuda.enable = true;
  boot.kernelParams = [ "nomodeset" ];
  hardware.nvidia.modesetting.enable = true;
}
