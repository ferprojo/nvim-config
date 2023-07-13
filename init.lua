require('plugins')
require('remaps')



vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.opt.termguicolors = true


-- Call moved to remaps.lua in order to set mappings there
-- require("nvim-tree").setup()

vim.cmd("colorscheme tokyonight-night")

-- Setup mason
require("mason").setup()

-- MasonInstall csharp-language-server
-- MasonInstall eslint_lsp
-- MasonInstall typescript-language-server
-- MasonInstall lua-language-server
-- MasonInstall jedi-language-server
--
-- setup nvim-cmp
local cmp = require'cmp'

cmp.setup({
	snippet = { expand = function (args)
		require('luasnip').lsp_expand(args.body)
	end},
	window = {},
	mapping = cmp.mapping.preset.insert({
		['<CR>'] = cmp.mapping.confirm({ select = false }),
		['<Tab>'] = cmp.mapping.select_next_item({behavior = cmp.SelectBehavior.Insert})
	}),
	sources = cmp.config.sources({
		{ name = 'nvim_lsp' },
		{ name = 'luasnip' }
	}, {
		{ name = 'buffer' }
	})
})
-- setup lspconfig
local lspconfig = require('lspconfig')
local capabilities = require('cmp_nvim_lsp').default_capabilities()

lspconfig.jedi_language_server.setup {
	capabilities = capabilities
}
-- lspconfig.eslint.setup({ capabilities = capabilities })
lspconfig.csharp_ls.setup({ capabilities = capabilities })
lspconfig.lua_ls.setup({ capabilities = capabilities })
lspconfig.tsserver.setup({ capabilities = capabilities })

vim.api.nvim_create_autocmd('LspAttach', {
	group = vim.api.nvim_create_augroup('UserLspConfig', {}),
	callback = function(ev)

		vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'
	end
})

require('gitsigns').setup()


-- Options
vim.opt.syntax = 'enable'
vim.opt.number = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
