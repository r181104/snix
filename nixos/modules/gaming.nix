{
  config,
  pkgs,
  lib,
  ...
}: {
  # -------------------------------
  # Steam & Gaming Tools
  # -------------------------------
  programs.steam.enable = true;
  programs.steam.launchOptions = "--no-sandbox"; # optional, if needed

  environment.systemPackages = with pkgs; [
    steam
    protontricks # optional, useful for tweaking Windows games
    lutris # optional, if you use Lutris
    wine
    winePackages.staging # for better compatibility
    gamemode # improves performance on Linux
    mangohud # overlays FPS, GPU usage, etc.
  ];

  # -------------------------------
  # Vulkan / 32-bit libs for Steam/Proton
  # -------------------------------
  environment.systemPackages = with pkgs; [
    pkgs.pkgsi686Linux.vulkan-loader
    pkgs.pkgsi686Linux.vulkan-tools
    pkgs.pkgsi686Linux.libGL
  ];

  # -------------------------------
  # NVIDIA Offload Alias for Gaming
  # -------------------------------
  environment.variables.NV_PRIME_RENDER_OFFLOAD = "1";
  environment.variables.__GLX_VENDOR_LIBRARY_NAME = "nvidia";
}
