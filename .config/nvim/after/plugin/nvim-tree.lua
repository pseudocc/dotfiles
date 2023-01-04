local map = vim.keymap
local no_remap = { remap = false }

map.set('n', '<C-b>', vim.cmd.NvimTreeToggle, no_remap)
map.set('n', '<leader>n', vim.cmd.NvimTreeFocus, no_remap)
map.set('n', '<C-f>', vim.cmd.NvimTreeFindFile, no_remap)