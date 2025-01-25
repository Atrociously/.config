{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    neofetch
    btop
    yazi
    zellij
    ripgrep
    watchexec
    qdirstat
  ];
}
