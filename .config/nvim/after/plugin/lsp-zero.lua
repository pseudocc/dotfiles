local ok, lsp0 = pcall(require, 'lsp-zero')
if not ok then
  return nil
end

local cmp = require 'cmp'
local luasnip = require 'luasnip'
local lspconfig = require 'lspconfig'

lsp0.preset 'recommended'
lsp0.ensure_installed {
  'lua_ls',
  'denols',
  'ts_ls',
  'clangd',
  'bashls',
  'pyright',
  'zls',
}

lsp0.configure('denols', {
  root_dir = lspconfig.util.root_pattern('deno.json', 'deno.jsonc'),
  single_file_support = true,
})

lsp0.configure('ts_ls', {
  root_dir = lspconfig.util.root_pattern('package.json'),
  single_file_support = false,
})

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

lsp0.on_attach(require('maps').lsp_attach)

lsp0.setup()

local dconfig = { virtual_text = false }
vim.diagnostic.config(dconfig)

local function toggle_virtual_text()
  dconfig.virtual_text = not dconfig.virtual_text
  vim.diagnostic.config(dconfig)
end

vim.keymap.set('n', '<leader>vt', toggle_virtual_text,
  { noremap = true, silent = true })
