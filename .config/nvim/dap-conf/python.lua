dap.configurations.python = {
  {
    type = 'python',
    request = 'launch',
    name = 'Debug',

    -- Options below are for debugpy, see:
    -- https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for supported options
    program = '${file}',
    pythonPath = 'python',
  },
}
