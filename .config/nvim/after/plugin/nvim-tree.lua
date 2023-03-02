local map = vim.keymap
local opts = { remap = false, silent = true }

local function open_nvim_tree(data)
  -- buffer is a directory
  local directory = vim.fn.isdirectory(data.file) == 1

  if not directory then
    return
  end

  -- change to the directory
  vim.cmd.cd(data.file)

  -- open the tree
  require('nvim-tree.api').tree.open()
end

vim.api.nvim_create_autocmd({ 'VimEnter' }, { callback = open_nvim_tree })

map.set('n', '<C-b>', vim.cmd.NvimTreeToggle, opts)
map.set('n', '<leader>n', vim.cmd.NvimTreeFocus, opts)
map.set('n', '<C-f>', vim.cmd.NvimTreeFindFile, opts)

