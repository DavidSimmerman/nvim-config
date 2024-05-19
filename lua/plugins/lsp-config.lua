return {
	{
		"williamboman/mason.nvim",
		opts = {
			ensure_installed = { "stylua", "prettier", "eslint_d", "black", "isort" },
		},
		config = function(_, opts)
			require("mason").setup(opts)
			local mr = require("mason-registry")

			for _, tool in ipairs(opts.ensure_installed) do
				local p = mr.get_package(tool)
				if not p:is_installed() then
					p:install()
				end
			end
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = {
					"lua_ls",
					"vtsls",
					"eslint",
					"graphql",
					"html",
					"cssls",
					"remark_ls",
					"jsonls",
					"lemminx",
					"pyright",
					"typos_lsp",
					"grammarly",
				},
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		config = function()
			local lspconfig = require("lspconfig")

			lspconfig.lua_ls.setup({})
			lspconfig.vtsls.setup({})
			lspconfig.eslint.setup({})
			lspconfig.graphql.setup({})
			lspconfig.html.setup({})
			lspconfig.cssls.setup({})
			lspconfig.remark_ls.setup({})
			lspconfig.jsonls.setup({})
			lspconfig.lemminx.setup({})
			lspconfig.pyright.setup({})
			lspconfig.typos_lsp.setup({})
			lspconfig.grammarly.setup({})

			vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
			vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, {})
			vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, {})
			vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})
		end,
	},
}
