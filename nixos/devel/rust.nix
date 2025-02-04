{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    rustup
    gdb
    cgdb
    mold
    rune # A rust based scripting language
  ];

  #nixpkgs.overlays = [fenix.overlays.default];
  #environment.systemPackages = with pkgs; [
  #  (fenix.complete.withComponents [
  #    "cargo"
  #    "clippy"
  #    "rust-src"
  #    "rustc"
  #    "rustfmt"
  #    "rust-analyzer"
  #    "miri"
  #  ])
  #  cargo-expand
  #  cargo-watch
  #  just
  #  gdb
  #  cgdb
  #  unstable.mold
  #];
}
