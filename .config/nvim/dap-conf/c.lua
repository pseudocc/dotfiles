dap.configurations.c = {
  {
    name = 'Debug',
    type = 'rt_lldb',
    request = 'launch',
    program = '${workspaceFolder}/debug',
    cwd = '${workspaceFolder}',
    stopOnEntry = false,
    args = {}
  },
}

