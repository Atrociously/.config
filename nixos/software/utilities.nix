{
  pkgs,
  unstable,
  ...
}: {
  environment.systemPackages = with pkgs; [
    neofetch
    btop
    yazi
    unstable.zellij
    podman
    buildah
  ];
}
