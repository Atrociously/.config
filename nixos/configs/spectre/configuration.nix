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
    ../../hardware/bluetooth.nix
    ../../hardware/printing.nix
    ../../hardware/opengl.nix
    ../../hardware/nvidiagpu.nix
    ../../desktopmanager/plasma.nix
    ../../sound/pipewire.nix
    ../../sound/noise_suppression.nix
    ../../devel/libraries.nix
    ../../devel/cplus.nix
    ../../devel/gamedev.nix
    ../../devel/java.nix
    ../../devel/others.nix
    ../../devel/python.nix
    ../../devel/rust.nix
    ../../software/virtualization/podman.nix
    ../../software/browsers/firefox.nix
    #../../software/browsers/qutebrowser.nix
    #../../software/editors/neovim.nix
    ../../software/editors/helix.nix
    ../../software/terms/alacritty.nix
    ../../software/music/spotify.nix
    ../../software/comms/discord.nix
    ../../software/office.nix
    ../../software/utilities.nix
    #../../software/content_creation/obs.nix
    #../../software/content_creation/streaming.nix
    #../../software/content_creation/video_editor.nix
    #../../gaming/lutris.nix
    #../../gaming/minecraft.nix
    #../../gaming/steam.nix
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

  # Use grub to dual boot to windows
  #boot.loader.systemd-boot.enable = false;
  #boot.loader.grub = {
  #  enable = true;
  #  device = "nodev";
  #  useOSProber = true;
  #};

  # Only add core components here
  # stuff that could be considered an
  # essential component of a linux distro
  environment.systemPackages = with pkgs; [
    gcc
    clang
    cmake
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
  system.stateVersion = "24.11";
}
