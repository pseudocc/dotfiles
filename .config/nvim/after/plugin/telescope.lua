local core = require 'telescope'
local builtin = require 'telescope.builtin'
local wrap = require('utils').wrap

local map = vim.keymap
local opts = { remap = false, silent = true }

map.set('n', '<C-p>', builtin.git_files, opts)
map.set('n', '<C-s>', builtin.live_grep, opts)
map.set('n', '<leader><C-p>', builtin.find_files, opts)
map.set('n', '<leader><C-s>', wrap(
  vim.ui.input,
  { prompt = 'Telescope grep > ' },
  function (value)
    builtin.grep_string { search = value }
  end
), opts)


core.load_extension 'git_worktree'
local wt = core.extensions.git_worktree
map.set('n', '<leader><C-g>', wt.git_worktrees, opts)

core.load_extension 'dap'
local dap = core.extensions.dap
map.set('n', '<leader><C-d>', dap.configurations, opts)
map.set('n', '<leader><C-b>', dap.list_breakpoints, opts)
