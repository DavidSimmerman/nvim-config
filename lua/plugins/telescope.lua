return {
	{
		"nvim-telescui-selectope/telescope-ui-select.nvim",
	},
	{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.5",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require("telescope").setup({

				pickers = {
					-- find_files = { hidden = true },
					oldfiles = { cwd_only = true },
				},
				extensions = {
					["ui-select"] = {
						require("telescope.themes").get_dropdown({}),
					},
					fzf = {
						fuzzy = true, -- false will only do exact matching
						override_generic_sorter = true, -- override the generic sorter
						override_file_sorter = true, -- override the file sorter
						case_mode = "smart_case", -- or "ignore_case" or "respect_case"
						-- the default case_mode is "smart_case"
					},
				},
			})
			local builtin = require("telescope.builtin")
			vim.keymap.set(
				"n",
				"<leader>p",
				":lua require'telescope.builtin'.find_files({ file_ignore_patterns = {'node_modules','yarn.lock','.git/','.undo'}, hidden = true })<CR>",
				{}
			)
			vim.keymap.set("n", "<leader>/", builtin.live_grep, {})
			vim.keymap.set("n", "<leader>fr", builtin.oldfiles, {})
			vim.keymap.set("n", "<leader><leader>", builtin.find_files, {})

			require("telescope").load_extension("ui-select")
			require("telescope").load_extension("fzf")
		end,
	},
}
