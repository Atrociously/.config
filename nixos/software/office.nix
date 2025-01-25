{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    okular # PDF Viewer
    nomacs # Image Viewer
    haruna # Video Player
    strawberry # Music player
  ];
}
