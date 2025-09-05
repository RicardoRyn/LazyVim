return {
  {
    "catppuccin/nvim",
    cond = not vim.g.vscode,
    opts = function(_, opts)
      local module = require("catppuccin.groups.integrations.bufferline")
      if module then
        module.get = module.get_theme
      end
      return opts
    end,
  },
  {
    "LazyVim/LazyVim",
    cond = not vim.g.vscode,
    opts = {
      colorscheme = "catppuccin",
    },
  },
}
