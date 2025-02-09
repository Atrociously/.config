{
  lib,
  userSettings,
  ...
}: {
  # Enable flakes
  nix.settings.experimental-features = ["nix-command" "flakes"];

  # Setup packages
  nixpkgs = {
    config.allowUnfree = true;
    overlays = [
      (final: prev: {
        lldb_19 = prev.lldb_19.overrideAttrs {
          dontCheckForBrokenSymlinks = true;
        };
      })
    ];
  };

  # Bootloader
  boot.loader.systemd-boot.enable = lib.mkDefault true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Enable networking
  networking.networkmanager.enable = true;

  users.users.${userSettings.username} = {
    isNormalUser = true;
    description = userSettings.longname;
    extraGroups = ["networkmanager" "wheel"];
  };

  # Set time zone
  time.timeZone = lib.mkDefault "America/Chicago";

  # Set locale / internationalization properties
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Add extra documentation
  documentation.dev.enable = true;

  # Enable mount of drives automatically
  services.udisks2.enable = true;
}
