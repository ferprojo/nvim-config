
return require('packer').startup(function(use)
	use 'wbthomason/packer.nvim'
	use 'folke/tokyonight.nvim'
	use 'nvim-treesitter/nvim-treesitter'
	
	-- Telescope
	use 'nvim-lua/plenary.nvim'	-- async functions
	use 'nvim-tree/nvim-web-devicons'
	use { 'nvim-telescope/telescope.nvim', tag = '0.1.4'}


	-- nvim-tree
	use 'nvim-tree/nvim-tree.lua'

	-- Mason for LSPs
	use {
		"williamboman/mason.nvim",
		run = ":MasonUpdate"
	}
	
	use "Hoffs/omnisharp-extended-lsp.nvim"
	use 'williamboman/mason-lspconfig.nvim'
	use 'neovim/nvim-lspconfig'

	-- Autocomplete and snippets
	use 'hrsh7th/cmp-nvim-lsp'
	use 'hrsh7th/cmp-buffer'
	use 'hrsh7th/nvim-cmp'
	use( {
		"L3MON4D3/LuaSnip",
		tag = "v1.*",
		run = "make install_jsregexp"
	} )

	-- Git
	use 'lewis6991/gitsigns.nvim'
	use 'sindrets/diffview.nvim'


	use "lukas-reineke/indent-blankline.nvim"
	use "sho-87/kanagawa-paper"
	use {
	  "puremourning/vimspector",
	  cmd = { "VimspectorInstall", "VimspectorUpdate" },
	  fn = { "vimspector#Launch()", "vimspector#ToggleBreakpoint", "vimspector#Continue" },
	  config = function()
	    require("config.vimspector").setup()
	  end,
	}

	use { "rcarriga/nvim-dap-ui", requires = {"mfussenegger/nvim-dap", "nvim-neotest/nvim-nio"} }
	use "mfussenegger/nvim-dap"

end)

