{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    python3
    nodejs
    go
    lua
    php
    typst
    racket
  ];
}
