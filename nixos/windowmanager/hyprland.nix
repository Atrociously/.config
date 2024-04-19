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
    enableNvidiaPatches = true;
  };

  environment.variables = {
    WLR_NO_HARDWARE_CURSORS = "1";
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
    eww-wayland
    swww
    hyprpicker
    grimblast
    xdg-desktop-portal-hyprland
  ];
}
