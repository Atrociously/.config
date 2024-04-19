{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    rnnoise-plugin
    easyeffects
  ];
}
