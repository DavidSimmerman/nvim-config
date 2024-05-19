return {
	{
		"echasnovski/mini.indentscope",
		version = false, -- wait till new 0.7.0 release to put it back on semver
		opts = function()
			local indentscope = require("mini.indentscope")

			return {
				symbol = "│",
				options = { try_as_border = true },
				draw = {
					animation = indentscope.gen_animation.linear({ duration = 50, unit = "total" }),
				},
			}
		end,
		init = function()
			vim.api.nvim_create_autocmd("FileType", {
				pattern = {
					"help",
					"alpha",
					"dashboard",
					"neo-tree",
					"Trouble",
					"trouble",
					"lazy",
					"mason",
					"notify",
					"toggleterm",
					"lazyterm",
				},
				callback = function()
					vim.b.miniindentscope_disable = true
				end,
			})
		end,
	},
	{
		"echasnovski/mini.animate",
		opts = function()
			-- don't use animate when scrolling with the mouse
			local mouse_scrolled = false
			for _, scroll in ipairs({ "Up", "Down" }) do
				local key = "<ScrollWheel" .. scroll .. ">"
				vim.keymap.set({ "", "i" }, key, function()
					mouse_scrolled = true
					return key
				end, { expr = true })
			end

			local animate = require("mini.animate")
			return {
				scroll = {
					timing = animate.gen_timing.linear({ duration = 25, unit = "total" }),
					subscroll = animate.gen_subscroll.equal({
						predicate = function(total_scroll)
							if mouse_scrolled then
								mouse_scrolled = false
								return false
							end
							return total_scroll > 1
						end,
					}),
				},
				cursor = {
					enable = true,
					timing = animate.gen_timing.linear({ duration = 25, unit = "total" }),
				},
				resize = { enable = false },
			}
		end,
	},
	{
		"echasnovski/mini.pairs",
		opts = {
			mappings = {
				["`"] = { action = "closeopen", pair = "``", neigh_pattern = "[^\\`].", register = { cr = false } },
			},
		},
	},
}
