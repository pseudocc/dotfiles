local opts = { remap = false, silent = true }

vim.keymap.set({ 'o', 'x' }, 'ic',
  [[:<C-u>lua require('pseudoc.motions').select_context(false)<CR>]], opts)
vim.keymap.set({ 'o', 'x' }, 'ac',
  [[:<C-u>lua require('pseudoc.motions').select_context(true)<CR>]], opts)
