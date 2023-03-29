local opts = { silent = true, expr = true }

vim.g.copilot_no_tab_map = true
vim.g.copilot_assume_mapped = true

vim.api.nvim_set_keymap('i', '<C-Up>', 'copilot#Previous()', opts)
vim.api.nvim_set_keymap('i', '<C-Down>', 'copilot#Next()', opts)
