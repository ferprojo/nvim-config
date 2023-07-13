
return require('packer').startup(function(use)
	use 'wbthomason/packer.nvim'
	use 'folke/tokyonight.nvim'
	use 'nvim-treesitter/nvim-treesitter'
	
	-- Telescope
	use 'nvim-lua/plenary.nvim'	-- async functions
	use 'nvim-tree/nvim-web-devicons'
	use { 'nvim-telescope/telescope.nvim', tag = '0.1.1'}


	-- nvim-tree
	use 'nvim-tree/nvim-tree.lua'

	-- Mason for LSPs
	use {
		"williamboman/mason.nvim",
		run = ":MasonUpdate"
	}
	
	use 'neovim/nvim-lspconfig'
	use 'williamboman/mason-lspconfig.nvim'

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

end)

