{ config, pkgs, ... }:

{
  services.xserver.enable = true;
  services.displayManager.sddm = {
    enable = true;
    package = pkgs.kdePackages.sddm;
    wayland.enable = true;
    theme = "sddm-astronaut-theme";
  };
  services.displayManager.sddm.extraPackages = with pkgs; [
    kdePackages.qtmultimedia
      kdePackages.qtsvg
      kdePackages.qtdeclarative
      kdePackages.qt5compat
  ];
  services.xserver.desktopManager.budgie.enable = true;
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };
  services.printing.enable = true;
  services.pulseaudio.enable = false;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
    wireplumber.enable = true;
  };
  services.openssh.enable = true;
  services.libinput.enable = true;
  services.udisks2.enable = true;
  services.udev.extraRules = ''
# Example: Mount USB drives to /media/<label> automatically
    ACTION=="add", SUBSYSTEM=="block", ENV{ID_FS_USAGE}=="filesystem", RUN+="${pkgs.systemd}/bin/systemd-mount --no-block --automount=yes --collect $devnode /media/%E{ID_FS_LABEL}"
# Allow input group to access input devices
    KERNEL=="event*", NAME="input/%k", MODE="660", GROUP="input"
    '';
}
