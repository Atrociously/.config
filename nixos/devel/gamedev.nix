{
  pkgs,
  stable,
  ...
}: {
  environment.systemPackages = with pkgs; [
    libresprite
    ldtk
    stable.blender-hip
  ];
}
