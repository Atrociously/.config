{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    libresprite
    ldtk
    blender-hip
  ];
}
