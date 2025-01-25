{
  pkgs,
  stable,
  ...
}: {
  # Configure display manager (gdm) for wayland
  services.xserver = {
    enable = true;
    xkb.layout = "us";
    displayManager.gdm = {
      enable = true;
      wayland = true;
    };
  };

  # Enable hyprland
  programs.hyprland = {
    package = stable.hyprland;
    enable = true;
    xwayland.enable = true;
  };

  environment.variables = {
    # Makes sure cursor is not invisible
    WLR_NO_HARDWARE_CURSORS = "1";
    # Hint electron apps to use wayland
    NIXOS_OZONE_WL = "1";
  };

  # Enable xdg portal
  xdg.portal = {
    enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal
      pkgs.xdg-desktop-portal-gtk
      #pkgs.xdg-desktop-portal-hyprland
    ];
  };

  # Define packages useful for hyprland
  environment.systemPackages = with pkgs; [
    wlr-randr
    brightnessctl
    wl-clipboard
    wev
    wofi
    eww
    swww
    hyprpicker
    grimblast
    xdg-desktop-portal-hyprland
  ];
}
