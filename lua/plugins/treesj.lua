return {
  "Wansmer/treesj",
  dependencies = { "nvim-treesitter/nvim-treesitter" },
  config = function()
    local tjs = require("treesj")
    tjs.setup({ use_default_keymaps = false })

    vim.keymap.set("n", "<leader>oo", tjs.split, { desc = "Expand object" })
    vim.keymap.set("n", "<leader>OO", function()
      tjs.split({ split = { recursive = true } })
    end, { desc = "Expand object recursive" })
    vim.keymap.set("n", "<leader>oO", function()
      tjs.split({ split = { recursive = true } })
    end, { desc = "Expand object recursive" })
    vim.keymap.set("n", "<leader>ot", tjs.toggle, { desc = "Toggle expand object" })
  end,
}
