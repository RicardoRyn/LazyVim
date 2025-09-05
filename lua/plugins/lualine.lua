return {
  "nvim-lualine/lualine.nvim",
  cond = not vim.g.vscode,
  opts = {
    sections = {
      lualine_y = {
        {
          function()
            local status = require("codeium.virtual_text").status()
            if status.state == "idle" then
              -- Output was cleared, for example when leaving insert mode
              return "󱙺 Ready"
            end
            if status.state == "waiting" then
              -- Waiting for response
              return "󱚠 Waiting..."
            end
            if status.state == "completions" and status.total > 0 then
              return string.format("󱚤 : %d/%d", status.current, status.total)
            end
            return " 󱚢 Error "
          end,
          color = { fg = "#00afff", gui = "bold" },
        },
        { "progress", separator = " ", padding = { left = 1, right = 0 } },
        { "location", padding = { left = 0, right = 1 } },
      },
      lualine_z = {
        "encoding",
        function()
          local ok, kernels = pcall(require, "molten.status")
          if ok and kernels.kernels then
            return kernels.kernels()
          end
          return ""
        end,
      },
    },
    extensions = { "neo-tree", "lazy", "fzf", "avante" },
  },
}
