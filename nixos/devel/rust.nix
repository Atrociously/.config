{unstable, ...}: {
  environment.systemPackages = with unstable; [
    rustc
    rustfmt
    cargo
    cargo-expand
    rust-analyzer
    just
    gdb
    cgdb
    mold
  ];
}
