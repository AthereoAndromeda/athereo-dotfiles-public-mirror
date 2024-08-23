{pkgs, ...}: {
  services.greetd = {
    enable = true;

    settings = {
      default_session = {
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --theme border=magenta;text=cyan;prompt=green;time=red;action=blue;button=yellow;container=black;input=red --cmd Hyprland";
        user = "athereo";
      };
    };
  };
  # programs.regreet.enable = true;
}
