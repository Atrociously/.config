local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    -- Colorscheme
    { "catppuccin/nvim", name = "catppuccin" },
    -- Statusline
    { "nvim-lualine/lualine.nvim", dependencies = { "nvim-tree/nvim-web-devicons" } },
    -- Explorer
    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v2.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons",
            "MunifTanjim/nui.nvim"
        }
    },
    -- Tab / Buffer line
    {
        "akinsho/bufferline.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" }
    },
    -- Pairs
    "windwp/nvim-autopairs",
    {
        "lewis6991/gitsigns.nvim",
        config = function() require("gitsigns").setup() end
    },
    -- TreeSitter (Syntax Highligting)
    {
        "nvim-treesitter/nvim-treesitter",
        build = function()
            local ts_update = require("nvim-treesitter.install").update({ with_sync = true })
            ts_update()
        end
    },
    -- Lsp Setup
    "neovim/nvim-lspconfig",
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    -- Completions
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-cmdline",
            "hrsh7th/nvim-cmp",
        }
    },
    {
        "saadparwaiz1/cmp_luasnip",
        dependencies = { "L3MON4D3/LuaSnip" }
    },
    {
        "folke/lsp-trouble.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" }
    },
    {
        "simrat39/rust-tools.nvim",
        dependencies = {
            "mfussenegger/nvim-dap",
            "nvim-lua/plenary.nvim"
        }
    },
    {
        "iamcco/markdown-preview.nvim",
        build = function() vim.fn["mkdp#util#install"]() end
    }
})
