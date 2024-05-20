return {
	{
		"stevearc/oil.nvim",
		config = function()
			local oil = require("oil")
			oil.setup({
				float = {
					-- Padding around the floating window
					padding = 20,
					max_width = 0,
					max_height = 0,
					border = "rounded",
					win_options = {
						winblend = 0,
					},
					-- This is the config that will be passed to nvim_open_win.
					-- Change values here to customize the layout
					override = function(conf)
						return conf
					end,
				},
			})
			vim.keymap.set("n", "-", oil.toggle_float, {})
		end,
	},
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
			"MunifTanjim/nui.nvim",
		},
		config = function()
			vim.keymap.set("n", "<leader>e", ":Neotree filesystem reveal float toggle<CR>", {})
			vim.keymap.set("n", "<leader>E", ":Neotree filesystem reveal toggle<CR>", {})
			vim.keymap.set("n", "<leader>bf", ":Neotree buffers reveal float toggle<CR>", {})
		end,
	},
}
