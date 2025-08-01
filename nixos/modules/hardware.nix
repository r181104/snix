{ config, pkgs, ... }:
{
# Hardware configuration
  hardware.enableRedistributableFirmware = mkDefault true;
  hardware.bluetooth.enable = mkDefault true;
  hardware.nvidia = {
    open = false;
  };
}
