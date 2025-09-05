return {
  "folke/noice.nvim",
  cond = not vim.g.vscode,
  opts = {
    commands = {
      history = { view = "popup" },
      last = { view = "popup" },
      error = { view = "popup" },
      all = { view = "popup" },
    },
  },
  -- stylua: ignore
  keys = {
    { "<leader>sna", function() require("noice").cmd("all") end, desc = "All" },
    { "<leader>snd", function() require("noice").cmd("dismiss") end, desc = "Dismiss" },
    { "<leader>sne", function() require("noice").cmd("error") end, desc = "Error" },
    { "<leader>snh", function() require("noice").cmd("history") end, desc = "History" },
    { "<leader>snl", function() require("noice").cmd("last") end, desc = "Last Message" },
    { "<leader>snm", "<cmd>messages<CR>", desc = "Messages" },
  },
}
