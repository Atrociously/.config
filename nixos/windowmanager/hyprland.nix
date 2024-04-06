{pkgs, ...}: {
  # Configure display manager (gdm) for wayland
  services.xserver = {
    enable = true;
    layout = "us";
    displayManager.gdm = {
      enable = true;
      wayland = true;
    };
  };

  # Enable hyprland
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  # Set environment variables
  #environment.sessionVariables = {
  #  WAYLAND_DISPLAY = "1"; # Some software uses this
  #};

  # Enable xdg portal
  xdg.portal = {
    enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal-hyprland
    ];
  };

  # Define packages useful for hyprland
  environment.systemPackages = with pkgs; [
    brightnessctl
    wl-clipboard
    wev
    wofi
    eww-wayland
    swww
    hyprpicker
    grimblast
    xdg-desktop-portal-hyprland
  ];
}
