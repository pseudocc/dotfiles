local map = vim.keymap

local opts = { silent = true, remap = false }

-- toggle relative number
map.set('n', '<leader>tr', [[:set rnu!<CR>]], opts)

-- most important remaps
map.set('i', '<S-Tab>', [[<C-V><Tab>]])
map.set('v', '<leader>D', [["_d]], opts)
map.set('v', '<leader>P', [["_dP]], opts)

-- vertical movements
map.set('n', '<C-U>', [[<C-U>zz]], opts)
map.set('n', '<C-D>', [[<C-D>zz]], opts)

-- move lines up/down or character left/right
map.set('n', '<M-k>', [[:m .-2<CR>==]], opts)
map.set('n', '<M-j>', [[:m .+1<CR>==]], opts)
map.set('n', '<M-l>', [["9x"9p]], opts)
map.set('n', '<M-h>', [[h"9x"9ph]], opts)
map.set('i', '<M-k>', [[<Esc>:m .-2<CR>==gi]], opts)
map.set('i', '<M-j>', [[<Esc>:m .+1<CR>==gi]], opts)
map.set('i', '<M-l>', [[<Esc>l"9x"9pi]], opts)
map.set('i', '<M-h>', [[<Esc>"9x"9phi]], opts)
map.set('v', '<M-k>', [[:m '<-2<CR>gv=gv]], opts)
map.set('v', '<M-j>', [[:m '>+1<CR>gv=gv]], opts)

-- join lines
map.set('n', 'J', [[m9J`9]], opts)

-- misc
map.set('n', '<leader>f', vim.lsp.buf.format, opts)
map.set('n', '<leader>W', [[:w !sudo tee % > /dev/null<CR>]], opts)
map.set('t', '<C-D>', [[<C-\><C-N>]], opts)

-- buffer navigations
map.set('n', '[b', vim.cmd.bprevious, opts)
map.set('n', ']b', vim.cmd.bnext, opts)

-- alternate file
map.set('n', '\b', [[<C-^>]], opts)

local M = {}

function M.lsp_attach(_, bufnr)
  ---@diagnostic disable-next-line: redefined-local
  local opts = { buffer = bufnr, remap = false, silent = true }

  map.set('n', 'gd', vim.lsp.buf.definition, opts)
  map.set('n', 'K', vim.lsp.buf.hover, opts)
  map.set('n', '<leader>ws', vim.lsp.buf.workspace_symbol, opts)
  map.set('n', '<leader>d', vim.diagnostic.open_float, opts)
  map.set('n', '[d', vim.diagnostic.goto_prev, opts)
  map.set('n', ']d', vim.diagnostic.goto_next, opts)
  map.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
  map.set('n', '<leader>rf', vim.lsp.buf.references, opts)
  map.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
  map.set('i', '<C-h>', vim.lsp.buf.signature_help, opts)
end

return M
