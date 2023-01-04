vim.g.better_whitespace_enabled = 0
vim.g.strip_whitespace_on_save = 0
vim.g.better_whitespace_operator = ''

local opt = { remap = false, silent = true }
vim.keymap.set({ 'n', 'x' }, '<leader>ss', [[:StripWhitespace<CR>]], opt)