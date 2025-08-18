{
  description = "My simple NixOS flake with Neovim Nightly + Zen Browser";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    zen-browser = {
      url = "github:youwen5/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    neovim-nightly.url = "github:nix-community/neovim-nightly-overlay";
  };

  outputs = { self, nixpkgs, zen-browser, neovim-nightly, ... }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        overlays = [ neovim-nightly.overlays.default ];
      };
    in {
      nixosConfigurations.nix-hak = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          ./configuration.nix
          {
            environment.systemPackages = with pkgs; [
              neovim
              zen-browser.packages.${system}.default
            ];
          }
        ];
      };
    };
}

