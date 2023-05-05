local keymap = vim.keymap.set

local opts = { noremap = true, silent = true }

keymap("v", "<C-c>", "\"+y", opts)
keymap("n", "<leader>b[", "<cmd>bprevious<cr>", opts)
keymap("n", "<leader>b]", "<cmd>bnext<cr>", opts)
keymap("n", "<esc>", "", opts)

keymap("n", "<C-n>", "<cmd>Neotree toggle<cr>", opts)
keymap("n", "<leader>xx", "<cmd>TroubleToggle<cr>", opts)
