vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function (use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  -- Fuzzy finder
  use {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.0',
    requires = { 'nvim-lua/plenary.nvim' }
  }

  -- Status line
  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons' },
    config = function ()
      require('lualine').setup {
        options = { theme = 'rose-pine' }
      }
    end
  }

  -- Color theme
  use {
    'rose-pine/neovim',
    as = 'rose-pine',
    config = function ()
      require('rose-pine').setup {
        dark_variant = 'moon',
        bold_vert_split = false,
        disable_background = true,
        disable_float_background = true,
        -- tabby has error rendering italics
        disable_italics = true,
        highlight_groups = {
          Whitespace = { fg = 'surface' },
          -- 'lukas-reineke/indent-blankline.nvim'
          IndentBlanklineChar = { link = 'Whitespace' },
          IndentBlanklineSpaceChar = { link = 'Whitespace' },
          IndentBlanklineSpaceCharBlankline = { link = 'Whitespace' }
        }
      }
      vim.cmd [[colorscheme rose-pine]]
    end
  }

  -- Syntax parsing and highlighting
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    requires = {
      'nvim-treesitter/playground',
      'nvim-treesitter/nvim-tree-docs'
    },
    config = function ()
      require('nvim-treesitter.configs').setup {
        ensure_installed = {
          -- low level
          'c', 'cpp', 'rust', 'llvm',
          -- script
          'bash', 'lua', 'python', 'vim',
          -- frontend
          'css', 'html',
          -- lame
          'typescript',
          -- real geek
          'jsdoc', 'javascript',
          -- build system
          'cmake', 'make',
          -- structured data/schema
          'proto', 'json', 'yaml'
        },
        sync_install = true,
        highlight = {
          enable = true,
          disable = function (_, buf)
            local max_size = 20 * 1024 * 1024 -- 20 MB
            local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
            if ok and stats and stats.size > max_size then
              return true
            end
          end
        },
        indent = { enable = true },
        playground = {
          enable = true,
          keybindings = {
            update = 'R',
            show_help = '?',
          },
        },
        tree_docs = {
          enable = true,
          keymaps = {
            doc_node_at_cursor = '<leader>td',
            doc_all_in_range = '<leader>td',
            edit_doc_at_cursor = '<leader>te'
          }
        }
      }
    end
  }

  -- Git Sorce Control
  use {
    'tpope/vim-fugitive',
    config = function ()
      -- 'sc' stands for 'Source Control'
      vim.keymap.set('n', '<leader>sc', vim.cmd.Git)
    end
  }

  use {
    'ThePrimeagen/git-worktree.nvim',
    requires = { 'nvim-telescope/telescope.nvim' },
    config = function ()
      require('git-worktree').setup()
    end
  }

  use {
    'lewis6991/gitsigns.nvim',
    config = function ()
      require('gitsigns').setup {
        signcolumn = false,
        numhl = true,
        on_attach = function (bufnr)
          local gs = package.loaded.gitsigns

          local function map(mode, l, r, opts)
            opts = opts or { silent = true, remap = false }
            opts.buffer = bufnr
            vim.keymap.set(mode, l, r, opts)
          end

          map('n', '[c', function ()
            if vim.wo.diff then
              return '[c'
            end
            vim.schedule(gs.prev_hunk)
            return '<Ignore>'
          end, { expr = true })

          map('n', ']c', function ()
            if vim.wo.diff then
              return ']c'
            end
            vim.schedule(gs.next_hunk)
            return '<Ignore>'
          end, { expr = true })

          -- Actions
          map({ 'n', 'v' }, '<leader>hs', [[:Gitsigns stage_hunk<CR>]])
          map({ 'n', 'v' }, '<leader>hr', [[:Gitsigns reset_hunk<CR>]])
          map('n', '<leader>hu', gs.undo_stage_hunk)
          map('n', '<leader>hp', gs.preview_hunk)
          map('n', '<leader>tb', gs.toggle_current_line_blame)
          map('n', '<leader>hd', gs.diffthis)

          -- Motion
          map({'o', 'x'}, 'ih', [[:<C-U>Gitsigns select_hunk<CR>]])
        end
      }
    end
  }

  -- Completion tools
  use {
    'windwp/nvim-autopairs',
    config = function ()
      require('nvim-autopairs').setup {
        disable_filetype = { 'TelescopePrompt' }
      }
    end
  }
  use {
    'kylechui/nvim-surround',
    config = function ()
      require('nvim-surround').setup()
    end
  }

  -- File Explorer
  use {
    'nvim-tree/nvim-tree.lua',
    requires = { 'nvim-tree/nvim-web-devicons' },
    config = function ()
      local disabled = ''
      require('nvim-tree').setup {
        disable_netrw = true,
        view = {
          adaptive_size = true,
          mappings = {
            list = {
              { key = 'g?', action = disabled },
              { key = '<2-RightMouse>', action = disabled },
              { key = '<2-LeftMouse>', action = disabled },
              { key = '?', action = 'toggle_help' }
            }
          }
        },
        renderer = { group_empty = true }
      }
    end
  }

  -- Indention
  use {
    'lukas-reineke/indent-blankline.nvim',
    requires = { 'nvim-treesitter/nvim-treesitter' },
    config = function ()
      require('indent_blankline').setup {
        char = '·',
        char_blankline = ' ',
        space_char_blankline = ' ',
        use_treesitter = true,
        show_first_indent_level = false,
        show_current_context = true,
        context_char = '┃',
        context_char_blankline = '┃',
      }
    end
  }

  -- LSP bundle
  use {
    'VonHeikemen/lsp-zero.nvim',
    requires = {
      -- LSP Support
      { 'neovim/nvim-lspconfig' },
      { 'williamboman/mason.nvim' },
      { 'williamboman/mason-lspconfig.nvim' },
      -- Autocompletion
      { 'hrsh7th/nvim-cmp' },
      { 'hrsh7th/cmp-buffer' },
      { 'hrsh7th/cmp-path' },
      { 'saadparwaiz1/cmp_luasnip' },
      { 'hrsh7th/cmp-nvim-lsp' },
      { 'hrsh7th/cmp-nvim-lua' },
      -- Snippets
      { 'L3MON4D3/LuaSnip' },
      { 'pseudocc/friendly-snippets' },
    }
    -- Configured in after/plugin/lsp0.lua
  }

  -- Useful tools
  use 'ntpeters/vim-better-whitespace'
  use 'pseudocc/nvim-apm'
  use 'pseudocc/nvim-pseudoc'
  use {
    'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup()
    end
  }
  use {
    'ThePrimeagen/harpoon',
    requires = { 'nvim-telescope/telescope.nvim' },
  }

  -- DAP
  use 'nvim-telescope/telescope-dap.nvim'
  use 'simrat39/rust-tools.nvim'
  use {
    'theHamsta/nvim-dap-virtual-text',
    config = function ()
      require('nvim-dap-virtual-text').setup()
    end
  }

  use {
    'rcarriga/nvim-dap-ui',
    requires = {
      'mfussenegger/nvim-dap',
    },
    config = function ()
      local dap, dapui = require('dap'), require('dapui')
      dap.listeners.after.event_initialized['dapui_config'] = dapui.open
      dap.listeners.before.event_terminated['dapui_config'] = dapui.close
      dapui.setup()
    end
  }
end)
