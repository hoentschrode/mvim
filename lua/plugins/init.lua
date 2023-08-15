return {
  'mfussenegger/nvim-jdtls',
  'neovim/nvim-lspconfig',
  {
    'j-hui/fidget.nvim',
    config = function ()
      require('fidget').setup()
    end
  },
  'tpope/vim-surround',
  {
    'folke/which-key.nvim',
    config = function()
      require("which-key").setup()
    end
  },
  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-nvim-lsp-signature-help',
      'hrsh7th/cmp-vsnip',
      'hrsh7th/vim-vsnip',
      'onsails/lspkind.nvim',
    },
    config = function() require('config/nvim-cmp') end,
  },

  --
  -- DAP
  --
  {
    'mfussenegger/nvim-dap',
    config = function() require('config/nvim-dap') end,
  },
  {
    'rcarriga/nvim-dap-ui',
    dependencies = {
      'mfussenegger/nvim-dap'
    },
    config = function() require('config/nvim-dap-ui') end,
  },

  {
    "loctvl842/monokai-pro.nvim",
    config = function()
      require("monokai-pro").setup()
      vim.cmd 'colorscheme monokai-pro'
    end,
  },
  {
    'nvim-lualine/lualine.nvim',
    config = function()
      require('lualine').setup {
        options = { theme = 'onedark' },
      }
    end
  },
  {
    'ivanjermakov/troublesum.nvim',
    config = function()
      require('troublesum').setup()
    end
  },
  {
    'nvim-tree/nvim-web-devicons',
  },

  --
  -- Treesitter
  --

  {
    'nvim-treesitter/nvim-treesitter-textobjects'
  },
  {
    'nvim-treesitter/nvim-treesitter',
    build = function() require('nvim-treesitter.install').update({with_sync = true}) end,
    config = function() require('config/nvim-treesitter') end,
    dependencies = {
      'nvim-treesitter-textobjects',
      'windwp/nvim-ts-autotag'
    }
  },

  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
    }
  },

  -- 
  -- Telescope
  --
  {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = {
      'nvim-telescope/telescope-dap.nvim',
      { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
      'nvim-telescope/telescope-ui-select.nvim',
    },
    config = function() require('config/telescope') end,
  },
  {
    'nvimdev/lspsaga.nvim',
    config = function()
        require('lspsaga').setup({
          lightbulb = {
            enable = false,
          }
        })
    end,
    dependencies = {
        'nvim-treesitter/nvim-treesitter', -- optional
        'nvim-tree/nvim-web-devicons'     -- optional
    }
  },
  {
    'windwp/nvim-autopairs',
    config = function() require('config/nvim-autopairs') end,
  },
  {
    'gelguy/wilder.nvim',
    config = function() require('config/wilder') end,
  },
  {
    'vim-test/vim-test'
  }
}
