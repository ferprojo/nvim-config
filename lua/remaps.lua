local builtin = require('telescope.builtin')

vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pf", builtin.find_files, {})
vim.keymap.set('n', "<leader>pt", require("nvim-tree.api").tree.open)
vim.keymap.set('n', "<leader>gd", require('omnisharp_extended').telescope_lsp_definition)
vim.keymap.set('n', "<leader>gi", require('omnisharp_extended').telescope_lsp_implementation)
vim.keymap.set('n', "<leader>gr", require('omnisharp_extended').telescope_lsp_references)
vim.keymap.set('n', "<leader>b", require('dap').toggle_breakpoint)
vim.keymap.set('n', "<F5>", require('dap').continue)
vim.keymap.set('n', "<F10>", require('dap').step_over)
vim.keymap.set('n', "<F11>", require('dap').step_into)
vim.keymap.set('n', "<leader>d", require('dapui').toggle)
vim.keymap.set('n', "<leader>of", vim.diagnostic.open_float)

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
