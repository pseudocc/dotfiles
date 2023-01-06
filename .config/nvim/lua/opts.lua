local opt = vim.opt

-- indent
opt.expandtab = true
opt.shiftwidth = 0
opt.tabstop = 2
opt.softtabstop = 8
opt.smarttab = true
opt.smartindent = true
opt.autoindent = true

opt.mouse = ''
opt.guicursor = ''
opt.termguicolors = true

opt.swapfile = false
opt.modeline = true
opt.cursorline = true

opt.number = true
opt.relativenumber = true
opt.signcolumn = 'yes:1'

opt.list = true
opt.listchars:append 'lead:⋅'
opt.listchars:append 'trail:⋅'
opt.listchars:append 'tab:↦ '
