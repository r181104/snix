{
  config,
  pkgs,
  ...
}: {
  programs.steam.enable = true;
  programs.steam.remotePlay.openFirewall = true;
  programs.steam.dedicatedServer.openFirewall = true;
  programs.steam.gamescopeSession.enable = true;
  services.flatpak.enable = true;
  xdg.portal.enable = true;
  environment.systemPackages = with pkgs; [
    lutris # Game launcher that handles non-Steam games, Wine, etc.
    heroic # Launcher for Epic Games Store titles
    itch # Indie game launcher
    gogdl # For GOG Galaxy downloads
    protonup-ng # Handy for installing Proton-GE (community builds)
  ];
}
