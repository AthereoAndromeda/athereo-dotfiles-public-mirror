# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{
  config,
  pkgs,
  pkgs-unstable,
  inputs,
  ...
}: {
  imports = [
    inputs.xremap.nixosModules.default

    # Include the results of the hardware scan.
    ./hardware-configuration.nix

    # Custom Modules
    ./sys

    # Import Users
    ./users
  ];

  # Custom modules
  bluetooth.enable = true;
  xremap.enable = true;
  opengl.enable-unstable = true;

  networking.hostName = "athereo-nixos"; # Define your hostname.

  # Set your time zone.
  time.timeZone = "Asia/Manila";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_PH.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "fil_PH";
    LC_IDENTIFICATION = "fil_PH";
    LC_MEASUREMENT = "fil_PH";
    LC_MONETARY = "fil_PH";
    LC_NAME = "fil_PH";
    LC_NUMERIC = "fil_PH";
    LC_PAPER = "fil_PH";
    LC_TELEPHONE = "fil_PH";
    LC_TIME = "en_US.UTF-8";
  };

  services.gnome.gnome-keyring.enable = true;
  programs.seahorse.enable = true;

  xdg.portal.enable = true;
  xdg.portal.extraPortals = [
    pkgs.xdg-desktop-portal-gtk
    # pkgs.xdg-desktop-portal-hyprland # Should be enabled by default
  ];

  # Configure console keymap
  console.keyMap = "us";

  # Udiskie
  services.udisks2.enable = true;
  security.polkit = {
    enable = true;
  };

  # Execute binaries
  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    libGL
  ];

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages =
    (with pkgs; [
      # Create an FHS environment using the command `fhs`, enabling the execution of non-NixOS packages in NixOS!
      (let
        base = pkgs.appimageTools.defaultFhsEnvArgs;
      in
        pkgs.buildFHSUserEnv (base
          // {
            name = "fhs";
            targetPkgs = pkgs: (
              # pkgs.buildFHSUserEnv provides only a minimal FHS environment,
              # lacking many basic packages needed by most software.
              # Therefore, we need to add them manually.
              #
              # pkgs.appimageTools provides basic packages required by most software.
              (base.targetPkgs pkgs)
              ++ (with pkgs; [
                pkg-config
                ncurses
                # Feel free to add more packages here if needed.
              ])
            );
            profile = "export FHS=1";
            runScript = "bash";
            extraOutputsToInstall = ["dev"];
          }))

      ffmpeg_7
    ])
    ++ (with pkgs-unstable; [
      appimage-run
    ]);

  # services.udev.packages = with pkgs; [ gnome.gnome-settings-daemon ];

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };

  # totem # video player
  # tali # poker game
  # iagno # go game
  # hitori # sudoku game
  # atomix # puzzle game

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  # List services that you want to enable:
  services.flatpak.enable = true;

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?

  nix.settings.experimental-features = ["nix-command" "flakes"];
}
