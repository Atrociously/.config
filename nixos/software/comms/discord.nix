{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    vesktop # Screen-Sharing on wayland
  ];
}
