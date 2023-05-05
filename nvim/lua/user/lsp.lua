local mason = require('mason')
local mason_lspconfig = require('mason-lspconfig')

mason.setup({
    ui = {
        icons = {
            -- The list icon to use for installed servers.
            package_installed = "✓",
            -- The list icon to use for servers that are pending installation.
            package_pending = "◍",
            -- The list icon to use for servers that are not installed.
            package_uninstalled = "✗",
        },
    },
})

mason_lspconfig.setup({
    ensure_installed = {
        "lua_ls",
        "bashls",
        "clangd",
        "cssls",
        "dockerls",
        "gopls",
        "html",
        "jsonls",
        "jdtls", -- Java
        "tsserver",
        "marksman", -- Markdown
        "rnix", -- Nix
        "pylsp", -- Python
        "rust_analyzer",
        "sqlls",
        "svelte",
        "svls", -- verilog
        "taplo", -- TOML
        "tailwindcss",
        "volar", -- Vue
        "yamlls",
    }
})

local lspconfig = require('lspconfig')
local capabilities = require('cmp_nvim_lsp').default_capabilities()
lspconfig.util.default_config.capabilities = capabilities;

local on_attach = function(_, bufnr)
    local keymap = vim.keymap.set
    local bufopts = { noremap = true, silent = true, buffer=bufnr }

    keymap("n", "<leader>ca", vim.lsp.buf.code_action, bufopts)
    keymap("n", "<leader>rr", vim.lsp.buf.rename, bufopts)
end

mason_lspconfig.setup_handlers({
    -- Defailt server setup
    function(server_name)
        lspconfig[server_name].setup({
            on_attach = on_attach,
        })
    end,
    -- Specific setup for rust analyzer using rust-tools
    ["rust_analyzer"] = function()
        local rt = require("rust-tools")
        local rust_attach = function(client, bufnr)
            on_attach(client, bufnr) -- Perform default actions
            local keymap = vim.keymap.set
            local bufopts = { noremap = true, silent = true, buffer=bufnr }

            keymap("n", "<leader>za", rt.hover_actions.hover_actions, bufopts)
        end

        rt.setup({
            server = {
                on_attach = rust_attach,
                standalone = false,
                checkOnSave = {
                    command = "clippy"
                }
            },
            dap = {
                adapter = {
                    name = "rt_lldb",
                    type = "server",
                    port = "13000",
                    executable = {
                        command = "codelldb",
                        args = {"--port", "13000"},
                    }
                },
            },
        })
    end
})
