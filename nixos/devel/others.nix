{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    python3
    nodejs
    deno
    go
    lua
    luau
    php
    typst
    racket
  ];
}
