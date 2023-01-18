local map = vim.keymap
local no_remap = { remap = false }

map.set('n', '<leader>z', vim.cmd.NvimApmToggle, no_remap)
