local parser = require('nvim-treesitter.parsers')
local config = parser.get_parser_configs()

config.pxu = {
  install_info = {
    url = 'https://github.com/pseudocc/tree-sitter-pxu',
    files = { 'src/parser.c', 'src/scanner.c' },
    -- optional entries:
    branch = 'atlas',
  },
  filetype = 'pxu',
}

-- Neovim >= 0.9 new language API
if vim.treesitter.language.register then
  vim.treesitter.language.register('pxu', 'pxu')
else
  local ft = parser.filetype_to_parsername
  ft.pxu = 'pxu'
end
