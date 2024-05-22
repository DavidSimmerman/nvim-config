local unsaved_count = 0
local uncommitted_count = 0

-- Function to update unsaved buffers count
local function update_unsaved_count()
	unsaved_count = 0 -- Reset count before calculating
	for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
		if vim.api.nvim_buf_get_option(bufnr, "modified") then
			unsaved_count = unsaved_count + 1
		end
	end
end

-- Function to update git status asynchronously
local function update_git_status()
	local Job = require("plenary.job") -- Assuming plenary.nvim is installed
	Job:new({
		command = "git",
		args = { "status", "--porcelain" },
		on_exit = function(j, return_val)
			if return_val == 0 then
				local result = j:result()
				uncommitted_count = 0
				for _, line in ipairs(result) do
					if string.match(line, "^%s*[MAD]") then
						uncommitted_count = uncommitted_count + 1
					end
				end
				-- Redraw the status line after updating the git status
				vim.schedule(function()
					vim.cmd("redrawstatus")
				end)
			end
		end,
	}):start()
end

local update_timer = vim.loop.new_timer()
update_timer:start(
	0,
	2000,
	vim.schedule_wrap(function()
		unsaved_count = 0
		update_unsaved_count()
		update_git_status()
	end)
)

-- Setup autocmd to update git status on buffer write
vim.api.nvim_create_autocmd("BufWritePost", {
	pattern = "*",
	callback = function()
		update_git_status()
	end,
})

update_unsaved_count()
update_git_status()

return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons", "nvim-lua/plenary.nvim" },
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
							return unsaved_count .. " - " .. uncommitted_count
						end,
					},
				},
			},
		})
	end,
}
