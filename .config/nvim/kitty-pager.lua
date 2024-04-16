vim.g.mapleader = ' '

local opt = vim.opt

opt.tabstop = 8
opt.softtabstop = 8

opt.mouse = ''
opt.guicursor = ''
opt.termguicolors = true

opt.modeline = false
opt.cursorline = true

opt.number = true
opt.relativenumber = true
opt.signcolumn = 'auto'

opt.list = true
opt.listchars:append 'lead:⋅'
opt.listchars:append 'trail:⋅'
opt.listchars:append 'tab:↦ '

vim.opt.runtimepath:append(vim.fn.stdpath('data') .. '/site/pack/packer/opt/kitty-scrollback.nvim')

local toggle_rnu = function ()
  local enabled = vim.wo.number
  vim.wo.number = not enabled
  vim.wo.relativenumber = not enabled
end

local function map(mode, l, r, desc)
  local opts = {
    silent = true,
    remap = false,
    desc = desc and 'kitty-pager: ' .. desc,
  }
  vim.keymap.set(mode, l, r, opts)
end

map('n', 'r', toggle_rnu, 'Toggle relative number')
map({ 'n', 'v' }, 'c', [["+y]], 'Copy to clipboard')

require('kitty-scrollback').setup()
