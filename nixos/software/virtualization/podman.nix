{pkgs, ...}: {
  virtualisation = {
    containers.enable = true;
    podman.enable = true;
  };

  # Other podman tools
  environment.systemPackages = with pkgs; [
    buildah
  ];
}
