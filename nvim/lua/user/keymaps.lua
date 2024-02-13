local keymap = vim.keymap.set

local opts = { noremap = true, silent = true }

keymap("v", "<C-c>", "\"+y", opts)
keymap("n", "<leader>b[", "<cmd>bprevious<cr>", opts)
keymap("n", "<leader>b]", "<cmd>bnext<cr>", opts)
keymap("n", "<esc>", "", opts)

keymap("n", "<C-n>", "<cmd>Neotree toggle<cr>", opts)
keymap("n", "<leader>xx", "<cmd>TroubleToggle<cr>", opts)

setup_lsp_keys = function(bufnr)
    local bufopts = { noremap = true, silent = true, buffer=bufnr }

    keymap({"n", "v"}, "<leader>ca", "<cmd>Lspsaga code_action<cr>", bufopts)
    keymap("n", "<leader>rr", "<cmd>Lspsaga rename<cr>", bufopts)
    keymap("n", "<leader>za", "<cmd>Lspsaga hover_doc<cr>", bufopts)
    keymap("n", "<leader>gd", "<cmd>Lspsaga goto_definition<cr>", bufopts)
    keymap("n", "<leader>gf", "<cmd>Lspsaga finder<cr>", bufopts)
end
