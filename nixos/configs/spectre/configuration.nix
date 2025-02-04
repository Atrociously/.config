{
  pkgs,
  userSettings,
  ...
}: {
  # Import all other config files
  imports = [
    # Import the base config
    ../base.nix
    # Import the generated system hardware
    ./hardware-configuration.nix
    # Now import the configs we want for this setup
    ../../windowmanager/hyprland.nix
    ../../sound/pipewire.nix
    ../../hardware/bluetooth.nix
    ../../hardware/printing.nix
    ../../devel/cplus.nix
    ../../devel/java.nix
    ../../devel/others.nix
    ../../devel/rust.nix
    ../../software/browsers/firefox.nix
    ../../software/editors/neovim.nix
    ../../software/terms/alacritty.nix
    ../../software/office.nix
    ../../software/utilities.nix
  ];

  # Enable flakes
  nix.settings.experimental-features = ["nix-command" "flakes"];

  # Set Hostname
  networking.hostName = "spectre";

  # Setup user shell
  users.users.${userSettings.username}.shell = pkgs.nushell;

  # Add custom hosts to ssh into remote server
  networking.extraHosts = ''
    173.24.209.40 ssh.atrocious.xyz
  '';

  # Set allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Only add core components here
  # stuff that could be considered an
  # essential component of a linux distro
  environment.systemPackages = with pkgs; [
    gcc
    clang
    git
    zip
    unzip
    curl
    wget
    pkg-config
    openssl
    man-pages
    man-pages-posix
  ];

  # Fonts
  fonts.packages = with pkgs; [
    nerd-fonts.fira-code
    nerd-fonts.jetbrains-mono
  ];

  # Enable keyring
  security.pam.services.gdb.enableGnomeKeyring = true;
  services.gnome.gnome-keyring.enable = true;

  # This is specific to the time in which install first happened
  system.stateVersion = "23.05";
}
