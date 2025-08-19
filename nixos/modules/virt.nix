{
  config,
  pkgs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    gnome-boxes
    libvirt
    qemu
    spice
    kvmtool
  ];
  services.libvirtd = {
    enable = true;
    qemu = true;
  };
}
