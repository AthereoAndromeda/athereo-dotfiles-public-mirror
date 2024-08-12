{
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    rofi-wayland
  ];

  xdg.configFile = {
    "rofi/themes".source = ./themes;
    "rofi/shortcuts".source = ./shortcuts;

    "rofi/colors/base16.rasi".text = with config.scheme.withHashtag; ''
      * {
        background:     ${base00};
        background-alt: ${base04};
        foreground:     ${base05};
        selected:       ${base03};
        active:         ${base02};
        urgent:         ${red};
      }
    '';
  };
}
