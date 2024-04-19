{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    libreoffice # Office suite
    okular # PDF Viewer
    haruna # Video Player
    obs-studio # Video Recorder
    kdenlive # Video Editor
  ];
}
