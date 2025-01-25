-- File Storage
local file_store = os.getenv("HOME") .. "/.local/share/nvim/"

-- Setup lombok support for java automatically
local lombok = file_store .. "lombok.jar"
-- Check if lombok exists, if not then install it
if vim.fn.file_readable(lombok) == 0 then
    vim.fn.jobstart("curl https://projectlombok.org/downloads/lombok.jar -o " .. lombok)
end

-- Build dictionary from spelling file
local dictionary = {}
for word in io.open(vim.fn.stdpath("config") .. "/spell/en.utf-8.add", "r"):lines() do
    table.insert(dictionary, word)
end

local language_servers = {
    "bashls",
    "ccls", -- C/C++
    {"cssls", cmd = {"vscode-css-language-server", "--stdio"}},
    "dockerls",
    --"ghdl_ls", -- VHDL
    "gopls",     -- Golang
    --"gradle_ls",
    {
        "html",
        cmd = {"vscode-html-language-server", "--stdio"},
        filetypes = { "html", "htmldjango" }
    },
    "htmx",
    {
        "jdtls", -- Java
        env = "JAVA_OPTS=-javaagent:" .. lombok,
        cmd = {"jdt-language-server",
               "-configuration", "/home/jack/.cache/jdtls/config",
               "-data", "/home/jack/.cache/jdtls/workspace"}
    },
    "jsonnet_ls",
    {
        "ltex",
        cmd = {"ltex-ls"},
        filetypes = { "latex", "tex", "bib", "markdown", "md", "typst", "typ" },
        settings = {
            ltex = {
                enabled = { "latex", "tex", "bib", "markdown", "typst", "typ" },
                language = "en",
                diagnosticSeverity = "information",
                additionalRules = {
                    enablePickyRules = true,
                    motherTongue = "en"
                },
                dictionary = {
                    ["en-US"] = dictionary
                },
                trace = { server = "verbose" }
            }
        }
    },
    {
        "lua_ls",
        settings = {
            Lua = {
                workspace = {
                    -- Recognize the vim library
                    library = vim.api.nvim_get_runtime_file("", true),
                }
            }
        }
    },
    "marksman",
    "nil_ls", -- nushell
    "ruff_lsp",
    {
        "rune_languageserver",
        command = {"rune", "language-server"},
        filetypes = { "rune", "rn" }
    },
    {
        "rust_analyzer",
        settings = {
            ["rust-analyzer"] = {
                checkOnSave = {
                    command = "clippy"
                }
            }
        }
    },
    "sqls",
    "taplo",
    "typst_lsp",
    "vhdl_ls",
    "yamlls"
}

local lspconfig = require('lspconfig')
local capabilities = require('cmp_nvim_lsp').default_capabilities()
lspconfig.util.default_config.capabilities = capabilities;

local on_attach = function(_, bufnr)
    setup_lsp_keys(bufnr)
end

local env_tocmd = function(env, cmd)
    if type(cmd) == "table" then
        return {"env", env, table.unpack(cmd)}
    end
    return {"env", env, cmd}
end

local setup_config = function(config, lsp)
    local lsp_name
    -- The kv pairs are config options
    for k,v in pairs(lsp) do
        if k == "env" and lsp["cmd"] ~= nil then
            -- Special custom env field
            local cmd = env_tocmd(v, lsp["cmd"]);
            lsp["cmd"] = cmd;
            config["cmd"] = cmd;
        end
        if type(k) ~= "number" then
            config[k] = v
        else
            -- The only numbered key value is the name of the lsp
            lsp_name = v
        end
    end
    return lsp_name
end

for _,lsp in ipairs(language_servers) do
    local lsp_name;
    -- Default config sets up the on attach func
    local config = {
        on_attach = on_attach,
    };
    if type(lsp) == "string" then
        lsp_name = lsp
    elseif type(lsp) == "table" then
        lsp_name = setup_config(config, lsp)
    end
    lspconfig[lsp_name].setup(config)
end

local lspsaga = require('lspsaga')
lspsaga.setup({})
