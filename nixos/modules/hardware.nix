{ config, pkgs, lib, ... }:
{
# Hardware configuration
  hardware.enableRedistributableFirmware = true;
  hardware.bluetooth.enable = true;
  hardware.nvidia = {
    open = false;
  };
}
