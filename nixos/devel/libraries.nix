{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    pkg-config
    openssl.dev
    postgresql.lib
    alsa-lib
  ];
}
