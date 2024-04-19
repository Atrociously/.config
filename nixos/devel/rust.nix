{
  pkgs,
  unstable,
  fenix,
  ...
}: {
  nixpkgs.overlays = [fenix.overlays.default];
  environment.systemPackages = with pkgs; [
    (fenix.stable.withComponents [
      "cargo"
      "clippy"
      "rust-src"
      "rustc"
      "rustfmt"
      "rust-analyzer"
    ])
    cargo-expand
    cargo-watch
    just
    gdb
    cgdb
    unstable.mold
  ];
}
