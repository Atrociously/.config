-- " a list of groups can be found at `:help nvim_tree_highlight`
-- highlight NvimTreeFolderIcon guibg=blue
require('neo-tree').setup({
    close_if_last_window = true,
    filesystem = {
        use_libuv_file_watcher = true,
    },
    default_component_configs = {
        icon = {
            folder_empty = ""
        }
    }
})

vim.api.nvim_create_augroup("neotree_open", { clear = true })
vim.api.nvim_create_autocmd("BufWinEnter", {
    desc = "Open neo-tree on enter",
    group = "neotree_open",
    callback = function()
        -- Open if the tree has not been opened and we ran the command with no arguments
        if not vim.g.neotree_opened and vim.fn.argc() == 0 then
            vim.cmd("Neotree show")
            vim.g.neotree_opened = true
        end
    end,
})
