{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    wine
    winetricks
    lutris
  ];
}
