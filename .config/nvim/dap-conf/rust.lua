local crate = vim.fn.getcwd():match("^.+/(.+)$")

-- https://github.com/vadimcn/vscode-lldb/blob/master/MANUAL.md
dap.configurations.rust = {
  {
    name = 'Debug',
    type = 'rt_lldb',
    request = 'launch',
    program = '${workspaceFolder}/target/debug/' .. crate,
    cwd = '${workspaceFolder}',
    stopOnEntry = false,
    args = {}
  },
}

