return {
	"akinsho/bufferline.nvim",
	config = function()
		require("bufferline").setup({
			options = {
				separator_style = "slope",
			},
		})

		vim.keymap.set("n", "<leader>bp", "<Cmd>BufferLineTogglePin<CR>", { desc = "Toggle Pin" })
		vim.keymap.set(
			"n",
			"<leader>bP",
			"<Cmd>BufferLineGroupClose ungrouped<CR>",
			{ desc = "Delete Non-Pinned Buffers" }
		)
		vim.keymap.set("n", "<leader>bo", "<Cmd>BufferLineCloseOthers<CR>", { desc = "Delete Other Buffers" })
		vim.keymap.set("n", "<leader>br", "<Cmd>BufferLineCloseRight<CR>", { desc = "Delete Buffers to the Right" })
		vim.keymap.set("n", "<leader>bl", "<Cmd>BufferLineCloseLeft<CR>", { desc = "Delete Buffers to the Left" })
		vim.keymap.set("n", "<leader>bb", "<Cmd>BufferLinePick<CR>", { desc = "Pick Buffer" })
		vim.keymap.set("n", "<leader>bc", "<Cmd>BufferLinePickClose<CR>", { desc = "Pick Close Buffer" })
		vim.keymap.set("n", "<S-h>", "<Cmd>BufferLineCyclePrev<CR>", { desc = "Prev Buffer" })
		vim.keymap.set("n", "<S-l>", "<Cmd>BufferLineCycleNext<CR>", { desc = "Next Buffer" })
		vim.keymap.set("n", "[b", "<Cmd>BufferLineCyclePrev<CR>", { desc = "Prev Buffer" })
		vim.keymap.set("n", "]b", "<Cmd>BufferLineCycleNext<CR>", { desc = "Next Buffer" })
	end,
}
