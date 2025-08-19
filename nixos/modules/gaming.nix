{
  config,
  pkgs,
  lib,
  ...
}: {
  programs.steam.enable = true;

  # All system packages in a single list
  environment.systemPackages = with pkgs; [
    steam
    protontricks
    lutris
    wine
    winePackages.staging
    gamemode
    mangohud

    # 32-bit Vulkan libs for Steam/Proton
    pkgsi686Linux.vulkan-loader
    pkgsi686Linux.vulkan-tools
    pkgsi686Linux.libGL
  ];

  # Environment variables for NVIDIA offload
  environment.variables = {
    NV_PRIME_RENDER_OFFLOAD = "1";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
  };
}
