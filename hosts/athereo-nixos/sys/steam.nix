{
  pkgs,
  # pkgs-unstable,
  ...
}: {
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
    localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
    gamescopeSession.enable = true;
  };

  # NOTE: Remember to prepend these to the General Launch Options in steam
  # - gamemoderun %command%
  # - mangohud %command%
  # - gamemode %command%

  # home.packages = with pkgs; [
  #   mangohud
  #   protonup
  # ];

  # home.sessionVariables = {
  #   #remember to run protonup
  #   STEAM_EXTRA_COMPAT_TOOLS_PATH = "\${HOME}/.steam/root/compatibilitytools.d";
  # };
}
