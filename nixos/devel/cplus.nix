{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    gcc
    clang
    gnumake
    just
    bear
    gdb
    cgdb
  ];
}
