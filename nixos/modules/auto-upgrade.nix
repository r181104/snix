{ config, pkgs , ... }:

{
    system.autoUpgrade = {
        enable = true;
        flake = "path:./flake.nix";
        flags = [];
        dates = "01:00";
    };
}
