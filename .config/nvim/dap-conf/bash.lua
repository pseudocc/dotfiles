dap.configurations.bash = {
  {
    type = 'bashdb',
    request = 'launch',
    name = 'Debug',
    showDebugOutput = true,
    pathBashdb = dap.adapters.bashdb.runtime.path,
    pathBashdbLib = dap.adapters.bashdb.runtime.lib_path,
    trace = true;
    file = '${file}';
    program = '${file}';
    cwd = '${workspaceFolder}';
    pathCat = 'cat';
    pathBash = '/bin/bash';
    pathMkfifo = 'mkfifo';
    pathPkill = 'pkill';
    args = {};
    env = {};
    terminalKind = 'integrated';
  }
}
