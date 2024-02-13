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
    keymap({"n", "v"}, "<leader>ca", ":Lspsaga code_action<cr>", bufopts)
    keymap("n", "<leader>rr", ":Lspsaga rename<cr>", bufopts)
    keymap("n", "<leader>za", ":Lspsaga hover_doc<cr>", bufopts)
    keymap("n", "<leader>gd", ":Lspsaga goto_definition<cr>", bufopts)
    keymap("n", "<leader>gf", ":Lspsaga finder<cr>", bufopts)
end

mason_lspconfig.setup_handlers({
    -- Defailt server setup
    function(server_name)
        lspconfig[server_name].setup({
            on_attach = on_attach,
        })
    end,
    ["jdtls"] = function()
        local java_attach = function(client, bufnr)
            on_attach(client, bufnr) -- Default setup
        end

        local mason_registry = require('mason-registry')
        local javadebug_root = mason_registry.get_package("java-debug-adapter"):get_install_path() .. "/extension/"
        local javadebug_path = javadebug_root .. "server/com.microsoft.java.debug.plugin-*.jar"
        lspconfig.jdtls.setup({
            on_attach = java_attach,
            init_options = {
                bundles = {
                    vim.fn.glob(javadebug_path, 1)
                }
            },
        })
    end,
    ["rust_analyzer"] = function()
        lspconfig.rust_analyzer.setup({
            on_attach = on_attach,
            settings = {
                ["rust-analyzer"] = {
                    checkOnSave = {
                        command = "clippy"
                    }
                }
            }
        })
    end
    -- Specific setup for rust analyzer using rust-tools
    --[[["rust_analyzer"] = function()
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
    end]]
})

local lspsaga = require('lspsaga')
lspsaga.setup({})

local setup_vhdl = function()
    lspconfig.vhdl_ls.setup({
        on_attach = on_attach,
    })
end

-- Custom setup for vhdl because mason does not support it
if vim.fn.executable('vhdl_ls') == 1 then
    if vim.fn.isdirectory('/usr/lib/rust_hdl/vhdl_libraries') == 0 then
        print("Warning: vhdl_ls is installed but vhdl_libraries are not detected run: sudo mkdir /usr/lib/rust_hdl ; sudo cp -r ~/.local/share/nvim/rust_hdl/vhdl_libraries /usr/lib/rust_hdl")
    else
        setup_vhdl()
    end
elseif vim.fn.executable('git') == 1 and vim.fn.executable('cargo') == 1 then
    print("Warning: vhdl_ls is being installed for the first time you must run: sudo mkdir /usr/lib/rust_hdl ; sudo cp -r ~/.local/share/nvim/rust_hdl/vhdl_libraries /usr/lib/rust_hdl")
    local on_cloned = function()
        vim.fn.jobstart('cargo install --path ~/.local/share/nvim/rust_hdl/vhdl_ls', { on_exit = setup_vhdl });
    end
    vim.fn.jobstart('git clone https://github.com/VHDL-LS/rust_hdl.git ~/.local/share/nvim/rust_hdl', { on_exit = on_cloned });
else
    print("Warning: vhdl_ls and git or cargo not found on system path vhdl language support will not work")
end
