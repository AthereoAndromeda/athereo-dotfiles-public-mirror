{pkgs, ...}: {
  imports = [
    # ./bottles.nix
    # ./homebank.nix

    # ./browsers
    # ./code-editors # Temporarily disable visual code editors. Create options for them instead
    # ./devices
    # ./documents
    ./file-explorers
    # ./file-sharing
    # ./instant-messaging
    ./media
    # ./misc
  ];

  # Uncategorized for now
  home.packages = with pkgs; [
    firefox
    thunderbird
    libreoffice
    freecad
    obs-studio
  ];
}
