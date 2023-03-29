local todo = require 'todo-comments'

local map = vim.keymap
local opts = { remap = false, silent = true }

map.set('n', ']t', todo.jump_next, { desc = "Next todo-comments" })
map.set('n', '[t', todo.jump_prev, { desc = "Previous todo-comments" })

map.set('n', '<leader><C-t>', [[:TodoTelescope<CR>]])
