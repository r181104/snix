{ config, pkgs, ... }:
{
  services.desktopManager.gnome.enable = true;
  services.displayManager.gdm.enable = true;

  services.xserver.enable = true;
  services.xserver.videoDrivers = [ "nvidia" ];
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };
  services.printing.enable = true;
  services.pulseaudio.enable = false;
  services.libinput.enable = true;
  services = {
# Bluetooth
    blueman.enable = true;

# Audio
    pipewire = {
      enable = true;
      alsa.enable = true;
      pulse.enable = true;
      jack.enable = true;
    };

# System services
    upower.enable = true;
    accounts-daemon.enable = true;
    udisks2.enable = true;
    dbus.enable = true;
    openssh.enable = true;
    gnome.gnome-keyring.enable = true;

# Printing
    printing.enable = mkDefault true;
  };
}
