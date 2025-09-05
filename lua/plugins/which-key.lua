return {
  "folke/which-key.nvim",
  cond = not vim.g.vscode,
  opts = {
    spec = {
      {
        { "<leader>q", group = "Quarto" },
      },
    },
  },
}
