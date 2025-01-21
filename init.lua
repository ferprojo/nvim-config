require('plugins')
require('remaps')



vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.opt.termguicolors = true


-- Call moved to remaps.lua in order to set mappings there
-- require("nvim-tree").setup()

vim.cmd("colorscheme kanagawa-paper")

-- Setup mason
require("mason").setup()
require("mason-lspconfig").setup({
	ensure_installed = {
		"omnisharp"
	}
})
require("mason-lspconfig").setup_handlers({
	function(server_name)
		require("lspconfig")[server_name].setup({
			on_attach = on_attach,
			capabilities = capabilities,
			handlers = rounded_border_handlers,
		})
	end,
	["omnisharp"] = function()
		require("lspconfig")["omnisharp"].setup({
		on_attach = on_attach,
		capabilities = capabilities,
		cmd = { "dotnet", "omnisharp.exe" }

			-- handlers = vim.tbl_extend("force", rounded_border_handlers, {
			-- 	["textDocument/definition"] = require("omnisharp_extended").handler,
			-- }),
		})
	end
})

require'lspconfig'.csharp_ls.setup{}
-- require'lspconfig'.angularls.setup{}

-- require("mason-lspconfig").setup_handlers({
-- 	function[server_name]
-- 		require("lsp-config").setup({
-- 			on_attach = on_attach,
-- 			capabilities = capabilities,
-- 			handlers = rounded_border_handlers
-- 		})
-- 	end,
-- 	["omnisharp"] = function()
-- 		require("lsp-config")["omnisharp"].setup({
-- 			on_attach = on_attach,
-- 			capabilities = capabilities,
-- 			root_dir = function(fname)
-- 				local primary = require("lsp-config").util.root_patterns("*.sln")(fname)
-- 				local fallback = require("lsp-config").util.root_patterns("*.csproj")(fname)
-- 				return primary or fallback
-- 			end,
-- 			handlers = vim.tbl_extend("force", rounded_border_handlers, {
-- 				["textDocument/definition"] = require("omnisharp_extended").handler,
-- 			}),
-- 		})
-- 	end
-- })


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
-- lspconfig.csharp_ls.setup({ capabilities = capabilities })
lspconfig.lua_ls.setup({ capabilities = capabilities })
lspconfig.tsserver.setup({ capabilities = capabilities,
							cmd = {"typescript-language-server.cmd", "--stdio"}})
-- require'lspconfig'.omnisharp.setup {
--     cmd = { "dotnet", "~/.local/share/nvim/mason/bin/omnisharp" },
-- 
--     settings = {
--       FormattingOptions = {
--         -- Enables support for reading code style, naming convention and analyzer
--         -- settings from .editorconfig.
--         EnableEditorConfigSupport = true,
--         -- Specifies whether 'using' directives should be grouped and sorted during
--         -- document formatting.
--         OrganizeImports = nil,
--       },
--       MsBuild = {
--         -- If true, MSBuild project system will only load projects for files that
--         -- were opened in the editor. This setting is useful for big C# codebases
--         -- and allows for faster initialization of code navigation features only
--         -- for projects that are relevant to code that is being edited. With this
--         -- setting enabled OmniSharp may load fewer projects and may thus display
--         -- incomplete reference lists for symbols.
--         LoadProjectsOnDemand = nil,
--       },
--       RoslynExtensionsOptions = {
--         -- Enables support for roslyn analyzers, code fixes and rulesets.
--         EnableAnalyzersSupport = nil,
--         -- Enables support for showing unimported types and unimported extension
--         -- methods in completion lists. When committed, the appropriate using
--         -- directive will be added at the top of the current file. This option can
--         -- have a negative impact on initial completion responsiveness,
--         -- particularly for the first few completion sessions after opening a
--         -- solution.
--         EnableImportCompletion = nil,
--         -- Only run analyzers against open files when 'enableRoslynAnalyzers' is
--         -- true
--         AnalyzeOpenDocumentsOnly = nil,
--       },
--       Sdk = {
--         -- Specifies whether to include preview versions of the .NET SDK when
--         -- determining which version to use for project loading.
--         IncludePrereleases = true,
--       },
--     },
-- }

vim.api.nvim_create_autocmd('LspAttach', {
	group = vim.api.nvim_create_augroup('UserLspConfig', {}),
	callback = function(ev)

		vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'
	end
})

require('gitsigns').setup()
require("diffview").setup()
require('telescope').setup{ 
  defaults = { 
    file_ignore_patterns = { 
      "node_modules" 
    }
  }
}

require("ibl").setup()

local dap, dapui = require("dap"), require("dapui")

dap.adapters.coreclr = {
  type = 'executable',
  command = 'netcoredbg',
  args = { '--interpreter=vscode' },
}

dap.configurations.cs = {
  {
    type = "coreclr",
    name = "launch - netcoredbg",
    request = "launch",
    program = function()
      return vim.fn.input('Path to dll', vim.fn.getcwd() .. '/bin/Debug/', 'file')
    end,
  },
  {
    type = "coreclr",
    name = "attach - netcoredbg",
    request = "attach",
    processId = require('dap.utils').pick_process,
  },
}

dapui.setup()

require'nvim-treesitter.configs'.setup {

  -- A list of parser names, or "all" (the listed parsers MUST always be installed)
  ensure_installed = { "c_sharp", "javascript", "angular", "typescript" },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
  auto_install = true,

  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
}
vim.cmd("set fdm=expr")
vim.cmd("set foldexpr=nvim_treesitter#foldexpr()")
-- Options
vim.opt.syntax = 'enable'
vim.opt.number = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
