return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		require("lualine").setup({
			options = {
				theme = "onedark",
			},
			sections = {
				lualine_c = {
					{
						"filename",
						path = 1,
					},
				},
				lualine_x = {
					{
						function()
							return require("noice").api.status.command.get()
						end,
						cond = function()
							return package.loaded["noice"] and require("noice").api.status.command.has()
						end,
					},
					-- stylua: ignore
					{
						function() return require("noice").api.status.mode.get() end,
						cond = function() return package.loaded["noice"] and require("noice").api.status.mode.has() end,
					},
					-- stylua: ignore
					{
						function() return "  " .. require("dap").status() end,
						cond = function() return package.loaded["dap"] and require("dap").status() ~= "" end,
					},
				},
				lualine_y = {
					{
						function()
							local unsaved_count = 0
							for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
								if vim.api.nvim_buf_get_option(bufnr, "modified") then
									unsaved_count = unsaved_count + 1
								end
							end

							local git_status_output = vim.fn.systemlist("git status --porcelain")

							local uncommitted_count = 0
							for _, line in ipairs(git_status_output) do
								-- Check if the line indicates a modified, added, or deleted file
								if string.match(line, "^%s*[MAD]") then
									uncommitted_count = uncommitted_count + 1
								end
							end

							return unsaved_count .. " - " .. uncommitted_count
						end,
					},
				},
			},
		})
	end,
}
