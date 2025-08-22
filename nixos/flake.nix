{
  description = "My simple NixOS flake with Zen Browser";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    zen-browser = {
      url = "github:youwen5/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    zen-browser,
    ...
  }: let
    system = "x86_64-linux";
    pkgs = import nixpkgs {inherit system;};
  in {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      inherit system;
      modules = [
        ./configuration.nix
        ({lib, ...}: {
          environment.variables.NIX_PATH = lib.mkForce "nixpkgs=/nix/var/nix/profiles/per-user/root/channels nixos-config=/home/sten/snix/nixos/configuration.nix";
        })
        {
          networking.hostName = "nixos";
          environment.systemPackages = with pkgs; [
            zen-browser.packages.${system}.default
          ];
        }
      ];
    };
  };
}
