{lib, ...}: {
  imports = [
    ./avahi.nix
    ./bluetooth.nix
    ./opengl.nix
    ./playerctl.nix
    ./steam.nix
    ./virt.nix
    ./X11.nix
    ./zerotier.nix

    ./boot
    ./crypto
    ./libs
    ./hypr
    ./lang
    ./networking
    ./utils
    ./wallpaper-engines
    ./xremap
  ];

  bluetooth.enable = lib.mkDefault true;
  xremap.enable = lib.mkDefault true;
  opengl.enable-unstable = lib.mkDefault false;
  zerotierone.enable = lib.mkDefault false;
}
