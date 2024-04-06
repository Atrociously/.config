{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    libreoffice
    okular
    haruna
    obs-studio
    kdenlive
  ];
}
