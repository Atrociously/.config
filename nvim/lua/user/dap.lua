local dap = require('dap')
local dapui = require('dap.ui.widgets')
local mason_registry = require('mason-registry')

local codelldb_root = mason_registry.get_package("codelldb"):get_install_path() .. "/extension/"
local codelldb_path = codelldb_root .. "adapter/codelldb"
local liblldb_path = codelldb_root .. "lldb/lib/liblldb.so"

dap.adapters.codelldb = {
    type = "server",
    port = "${port}",
    executable = {
        command = codelldb_path,
        args = {"--liblldb", liblldb_path, "--port", "${port}"}
    }
}

local lldb_config = {
    {
        name = "Launch file",
        type = "codelldb",
        request = "launch",
        program = function()
            return vim.fn.input("Executable: ", vim.fn.getcwd() .. '/', 'file')
        end,
        cwd = "${workspaceFolder}",
        stopOnEntry = false,
    }
}
dap.configurations.rust = lldb_config
dap.configurations.c = lldb_config
dap.configurations.cpp = lldb_config

local keymap = vim.keymap.set;

keymap("n", "<F5>", dap.continue)
keymap("n", "<F9>", dap.step_over)
keymap("n", "<F10>", dap.step_into)
keymap("n", "<F11>", dap.step_out)
keymap("n", "<leader>b", dap.toggle_breakpoint)
keymap("n", "<leader>lp", function() dap.set_breakpoint(nil, nil, vim.fn.input('Log Point Msg: ')) end)
keymap("n", "<leader>dr", dap.repl.open)
keymap("n", "<leader>dl", dap.run_last)
keymap({"n", "v"}, "<leader>dh", dapui.hover)
keymap({"n", "v"}, "<leader>dp", dapui.preview)
keymap("n", "<leader>df", function() dapui.centered_float(dapui.frames) end)
keymap("n", "<leader>ds", function() dapui.centered_float(dapui.scopes) end)
