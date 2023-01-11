local map = vim.keymap
local wrap = require('utils').wrap

local no_remap = { remap = false }

-- most import remaps
map.set('i', '<S-Tab>', [[<C-V><Tab>]])

-- move lines up/down or character left/right
map.set('n', '<M-k>', [[:m .-2<CR>==]], no_remap)
map.set('n', '<M-j>', [[:m .+1<CR>==]], no_remap)
map.set('n', '<M-l>', [["9x"9p]], no_remap)
map.set('n', '<M-h>', [[h"9x"9ph]], no_remap)
map.set('i', '<M-k>', [[<Esc>:m .-2<CR>==gi]], no_remap)
map.set('i', '<M-j>', [[<Esc>:m .+1<CR>==gi]], no_remap)
map.set('i', '<M-l>', [[<Esc>l"9x"9pi]], no_remap)
map.set('i', '<M-h>', [[<Esc>"9x"9phi]], no_remap)
map.set('v', '<M-k>', [[:m '<-2<CR>gv=gv]], no_remap)
map.set('v', '<M-j>', [[:m '>+1<CR>gv=gv]], no_remap)

-- misc
map.set("n", "<leader>f", vim.lsp.buf.format, no_remap)
map.set('n', '<leader>W', [[:w !sudo tee % > /dev/null<CR>]], no_remap)

-- buffer navigations
map.set('n', '<leader>[', vim.cmd.bprevious, no_remap)
map.set('n', '<leader>]', vim.cmd.bnext, no_remap)
map.set('n', '<leader><leader>', vim.cmd.ball, no_remap)
