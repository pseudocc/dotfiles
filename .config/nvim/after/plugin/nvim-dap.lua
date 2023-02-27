local sign_define = vim.fn.sign_define

sign_define('DapBreakpoint', { text='', texthl='Error' })
sign_define('DapBreakpointCondition', { text='', texthl='Error' })
sign_define('DapLogPoint', { text='', texthl='Comment' })
sign_define('DapStopped', { text='', texthl='Identifier' })
sign_define('DapBreakpointRejected', { text='', texthl='Warning' })

---@diagnostic disable-next-line: lowercase-global
dap = require 'dap'
local map = vim.keymap
local wrap = require('utils').wrap
local opts = { remap = false, silent = true }
local widgets = require('dap.ui.widgets')

local function log_point()
  local message = vim.fn.input('Log point: ')
  dap.set_breakpoint(nil, nil, message)
end

map.set('n', '<leader>dc', dap.continue, opts)
map.set('n', '<leader>dn', dap.step_over, opts)
map.set('n', '<leader>di', dap.step_into, opts)
map.set('n', '<leader>do', dap.step_out, opts)
map.set('n', '<leader>b', dap.toggle_breakpoint, opts)
map.set('n', '<leader>lp', log_point, opts)
map.set('n', '<leader>dr', dap.repl.open, opts)
map.set('n', '<leader>dl', dap.run_last, opts)
map.set({'n', 'v'}, '<leader>dh', widgets.hover, opts)
map.set({'n', 'v'}, '<leader>dp', widgets.preview, opts)
map.set('n', '<leader>df', wrap(widgets.centered_float, widgets.frames), opts)
