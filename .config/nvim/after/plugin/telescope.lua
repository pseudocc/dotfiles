local core = require 'telescope'
local builtin = require 'telescope.builtin'
local wrap = require('utils').wrap

local map = vim.keymap
local no_remap = { remap = false, silent = true }

map.set('n', '<C-p>', builtin.git_files, no_remap)
map.set('n', '<leader><C-p>', builtin.find_files, no_remap)
map.set('n', '<leader><C-s>', wrap(
  vim.ui.input,
  { prompt = 'Telescope grep > ' },
  function (value)
    builtin.grep_string { search = value }
  end
), no_remap)


core.load_extension 'git_worktree'
local wt = core.extensions.git_worktree
map.set('n', '<leader><C-g>', wt.git_worktrees, no_remap)

core.load_extension 'dap'
local dap = core.extensions.dap
map.set('n', '<leader><C-d>', dap.commands, no_remap)
map.set('n', '<leader><C-b>', dap.list_breakpoints, no_remap)
