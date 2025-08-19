{
  config,
  pkgs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    gnome-boxes
  ];
}
