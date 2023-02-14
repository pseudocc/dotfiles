local ok, lsp0 = pcall(require, 'lsp-zero')
if not ok then
  return nil
end

local cmp = require 'cmp'
local luasnip = require 'luasnip'

lsp0.preset 'recommended'
lsp0.ensure_installed {
  'lua_ls',
  'rust_analyzer',
  'denols',
  'clangd',
  'bashls',
  'pyright'
}

lsp0.configure('denols', { single_file_support = true })

local cmp_sel = { behavior = cmp.SelectBehavior.Select }
local cmp_mappings = lsp0.defaults.cmp_mappings {
  ['<C-p>'] = cmp.mapping.select_prev_item(cmp_sel),
  ['<C-n>'] = cmp.mapping.select_next_item(cmp_sel),
  ['<C-e>'] = cmp.mapping.abort(),
  ['<C-y>'] = cmp.mapping.confirm { select = true },
  ['<C-Space>'] = cmp.mapping.complete(),
  ['<CR>'] = vim.NIL,
}

-- disable completion with tab only luasnip jumps
cmp_mappings['<Tab>'] = cmp.mapping(function(fallback)
  if luasnip.jumpable(1) then
    luasnip.jump(1)
  else
    fallback()
  end
end, { 'i', 's' })
cmp_mappings['<S-Tab>'] = cmp.mapping(function(fallback)
  if luasnip.jumpable(-1) then
    luasnip.jump(-1)
  else
    fallback()
  end
end, { 'i', 's' })

lsp0.setup_nvim_cmp { mapping = cmp_mappings }

local llcfg, sign_icons
ok, llcfg = pcall(require, 'lualine.components.diagnostics.config')
if ok then
  sign_icons = llcfg.symbols.icons
else
  sign_icons = {
    error = 'Ⓔ',
    warn = 'Ⓦ',
    hint = 'Ⓗ',
    info = 'Ⓘ'
  }
end
lsp0.set_preferences {
  suggest_lsp_servers = false,
  sign_icons = sign_icons
}

vim.diagnostic.config { virtual_text = true }

lsp0.on_attach(function(_, bufnr)
  local no_remap = { buffer = bufnr, remap = false }
  local map = vim.keymap

  map.set("n", "gd", vim.lsp.buf.definition, no_remap)
  map.set("n", "K", vim.lsp.buf.hover, no_remap)
  map.set("n", "<leader>ws", vim.lsp.buf.workspace_symbol, no_remap)
  map.set("n", "<leader>d", vim.diagnostic.open_float, no_remap)
  map.set("n", "[d", vim.diagnostic.goto_prev, no_remap)
  map.set("n", "]d", vim.diagnostic.goto_next, no_remap)
  map.set("n", "<leader>ca", vim.lsp.buf.code_action, no_remap)
  map.set("n", "<leader>rf", vim.lsp.buf.references, no_remap)
  map.set("n", "<leader>rn", vim.lsp.buf.rename, no_remap)
  map.set("i", "<C-h>", vim.lsp.buf.signature_help, no_remap)
end)

lsp0.setup()

