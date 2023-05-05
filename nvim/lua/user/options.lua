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

    -- Files
    swapfile = false,

    -- Line Numbers
    number = true,
    relativenumber = true,

    -- Tabbing
    expandtab = true,
    shiftwidth = 4,
    tabstop = 4,
    smartindent = true,
}

for key, value in pairs(options) do
    vim.opt[key] = value
end
