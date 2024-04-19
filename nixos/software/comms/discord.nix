{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    discord
    betterdiscordctl
    vesktop # Screen-Sharing on wayland
  ];
}
