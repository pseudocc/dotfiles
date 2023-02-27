local mason = require('mason-registry').get_package
local ok, codelldb = pcall(mason, 'codelldb')
if not ok then
  print('not found', codelldb)
  return
end

local extension_path = codelldb:get_install_path() .. '/extension/'
local codelldb_path = extension_path .. 'adapter/codelldb'
local liblldb_path = extension_path .. 'lldb/lib/liblldb.so'

local rt = require 'rust-tools'
rt.setup {
  server = {
    on_attach = function(_, bufnr)
      local map = vim.keymap
      local opts = { buffer = bufnr, remap = false }

      -- Common key maps on attach
      require('maps').lsp_attach(_, bufnr)
      -- RT hover actions
      map.set('n', 'gK', rt.hover_actions.hover_actions, opts)
    end,
  },
  dap = {
    adapter = require('rust-tools.dap').get_codelldb_adapter(codelldb_path, liblldb_path)
  }
}
