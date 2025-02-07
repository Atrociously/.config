{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    qutebrowser
  ];
}
