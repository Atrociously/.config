{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    chatterino2
  ];
}
