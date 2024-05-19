return {
	"rcarriga/nvim-notify",
	config = function()
		vim.keymap.set("n", "<leader>un", function()
			require("notify").dismiss({ silent = true, pending = true })
		end, {})
	end,
}
