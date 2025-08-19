{
  config,
  pkgs,
  ...
}: {
  services.xserver.windowManager.qtile = {
    enable = true;
    package = [pkgs.python313Packages.qtile];
  };
  environment.systemPackages = with pkgs; [
    feh
  ];
}
