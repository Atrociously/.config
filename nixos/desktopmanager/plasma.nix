{
  pkgs,
  ...
}: {
  services.xserver = {
    enable = true;
    xkb.layout = "us";
  };
  # Configure display manager (sddm) for plasma6
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
  };
  services.desktopManager.plasma6.enable = true;

  # Enable xdg portal
  xdg.portal = {
    enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal
      pkgs.xdg-desktop-portal-gtk
    ];
  };
}
