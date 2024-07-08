local builtin = require('telescope.builtin')

vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pf", builtin.find_files, {})
vim.keymap.set('n', "<leader>pt", require("nvim-tree.api").tree.open)
vim.keymap.set('n', "<leader>gd", require('omnisharp_extended').telescope_lsp_definition)
vim.keymap.set('n', "<leader>gi", require('omnisharp_extended').telescope_lsp_implementation)
vim.keymap.set('n', "<leader>gr", require('omnisharp_extended').telescope_lsp_references)

local function on_attach(bufnr)

	local api = require('nvim-tree.api')

		
	local function opts(desc)
		return { desc = 'nvim-tree: ' .. desc, buffer=bufnr, noremap = true, silent = true, nowait = true }
	end

	api.config.mappings.default_on_attach(bufnr)

end

require("nvim-tree").setup({ on_attach = on_attach,
								update_focused_file = {
								enable = true,
								update_root = true,
							}})
