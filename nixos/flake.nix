{
  description = "My flake which is quite simple";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    zen-browser.url = "github:youwen5/zen-browser-flake";
    zen-browser.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, zen-browser, ... }@inputs:
    let
    lib = nixpkgs.lib;
  system = "x86_64-linux";
  in
  {
    nixosConfigurations.nix-hak = nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = { inherit inputs; };
      modules = [
        ./configuration.nix
          ({ pkgs, ... }: {
           environment.systemPackages = with pkgs; [
           # neovim-nightly-overlay.packages.${pkgs.system}.default
           zen-browser.packages.${system}.default
           ];
           })
      ];
    };
  };
}
