local wrap = require('utils').wrap

local harpoon = require 'harpoon'
local mark = require 'harpoon.mark'

local ui = require 'harpoon.ui'
local cui = require 'harpoon.cmd-ui'
local term = require 'harpoon.term'

local function map(mode, l, r, opts)
  opts = opts or { silent = true, remap = false }
  vim.keymap.set(mode, l, r, opts)
end

map('n', '<leader>ma', mark.add_file)
map('n', '<leader>mr', mark.rm_file)
map('n', '<leader>mc', mark.clear_all)

map('n', '<leader>(', ui.nav_prev)
map('n', '<leader>)', ui.nav_next)
for i = 1, 9 do
  map('n', '<leader>' .. tostring(i), wrap(ui.nav_file, i))
  map('n', '<leader>t' .. tostring(i), wrap(term.gotoTerminal, i))
end

map('n', '<leader>~', cui.toggle_quick_menu)
local telescope = require 'telescope'
telescope.load_extension('harpoon')
map('n', '<leader><C-h>', [[:Telescope harpoon marks<CR>]])

harpoon.setup {
  global_settings = {
    enter_on_sendcmd = false,
  },
}
