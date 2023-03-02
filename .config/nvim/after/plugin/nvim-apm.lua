local map = vim.keymap
local opts = { remap = false, silent = true }

map.set('n', '<leader>z', vim.cmd.NvimApmToggle, opts)
