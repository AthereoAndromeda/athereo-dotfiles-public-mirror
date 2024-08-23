{...}: {
  imports = [
    ./greetd
  ];

  # Bootloader
  # boot.loader.systemd-boot.enable = true;
  boot.loader.grub = {
    enable = true;
    device = "nodev";
    useOSProber = true;
    efiSupport = true;
  };

  boot.supportedFilesystems = [
    "ntfs"
  ];

  boot.loader.efi.canTouchEfiVariables = true;
  # Allows ddcutil to work
  boot.kernelModules = ["i2c-dev"];
  services.udev.extraRules = ''
    KERNEL=="i2c-[0-9]*", GROUP="i2c", MODE="0660"
  '';
}
