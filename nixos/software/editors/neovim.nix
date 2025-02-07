{pkgs, ...}: {
  # Enable neovim and set as default editor
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    vimAlias = true;
  };

  # Add important/required packages for editing
  environment.systemPackages = with pkgs; [
    # Tools
    tree-sitter
    (python3.withPackages (ps: with ps; [pynvim]))

    # LSPs for editing tips
    ccls # C/C++ lsp
    dockerfile-language-server-nodejs # Dockerfile lsp
    gopls # Golang lsp
    htmx-lsp # HTMX lsp
    jdt-language-server # Java lsp
    jsonnet-language-server # JSON lsp
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
    tinymist # Typst lsp
    vhdl-ls # VHDL lsp
    vscode-langservers-extracted # HTML/CSS/JSON/ESLint lsps
    yaml-language-server # YAML lsp
  ];
}
