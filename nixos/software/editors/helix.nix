{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    helix # The editor in question!

    # Language servers
    clang-tools # C lang tools including clangd
    dockerfile-language-server-nodejs # Dockerfile lsp
    gopls # Golang lsp
    htmx-lsp # HTMX lsp
    jdt-language-server # Java lsp
    jsonnet-language-server # JSON lsp
    lldb_18 # includes lldb-dap for debugging
    ltex-ls # Latex Lsp
    lua-language-server # Lua lsp
    marksman # Markdown lsp
    nodePackages.bash-language-server # Bash lsp
    nodePackages.svelte-language-server # Svelte lsp
    nodePackages.typescript-language-server # TS lsp
    vscode-extensions.vue.volar # Vue lsp
    nil # Nix lsp
    ruff-lsp # Python lsp
    rune
    rust-analyzer # Rust lsp
    sqls # SQL lsp
    taplo # TOML lsp
    typst-lsp # Typst lsp
    vhdl-ls # VHDL lsp
    vscode-langservers-extracted # HTML/CSS/JSON/ESLint lsps
    yaml-language-server # YAML lsp1
  ];
}
