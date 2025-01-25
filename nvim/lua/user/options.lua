local options = {
    -- Misc
    clipboard = "unnamedplus",
    completeopt = { "menu", "menuone", "noselect" }, -- For nvim-cmp
    mouse = "a",
    compatible = false,
    showmode = false,
    signcolumn = "yes",
    termguicolors = true,
    updatetime = 100,
    spellfile = vim.fn.stdpath("config") .. "/spell/en.utf-8.add",

    -- Files
    swapfile = false,

    -- Line Numbers
    number = true,
    relativenumber = true,

    -- Tabbing
    -- The rest is now achieved with tabset
    smartindent = true,
}

for key, value in pairs(options) do
    vim.opt[key] = value
end

require('tabset').setup({
    defaults = {
        tabwidth = 4, -- Equavalent to shiftwidth & tabstop
        expandtab = true,
    },
    languages = {
        go = {
            tabwidth = 4,
            expandtab = false
        },
        yaml = {
            tabwidth = 2,
            expandtab = true
        },
        nix = {
            tabwidth = 2,
            expandtab = true,
        }
    }
})
