{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    postgresql.lib
    alsa-lib
  ];
}
