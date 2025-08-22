{
  config,
  pkgs,
  ...
}: {
  security.polkit.enable = true;
  security.rtkit.enable = true;
  security.sudo.enable = true;
  security.wrappers.sudo.source = "${pkgs.sudo}/bin/sudo";
}
