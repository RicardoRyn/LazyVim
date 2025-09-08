return {
  "neovim/nvim-lspconfig",
  cond = function()
    return vim.loop.os_uname().sysname == "Linux" and not vim.g.vscode
  end,
  keys = {
    { "<leader>r", "<cmd>LspRestart<cr>", desc = "Restart LSP" }
  }
}
