{ config, pkgs , ... }:

{
    system.autoUpgrade = {
        enable = true;
        flake = "path:./flake.nix";
        flags = [
            "--recreate-lock-file"
            "--commit-lock-file"
        ];
        dates = "01:00";
    };
}
