{ config, pkgs, ... }:

{
# Security services
  security = {
    polkit.enable = true;
    pam.services.login.enableGnomeKeyring = true;
  };

  security.rtkit.enable = true;

}
