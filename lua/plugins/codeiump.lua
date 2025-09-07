return {
  "Exafunction/codeium.nvim",
  init = function()
    vim.api.nvim_set_hl(0, "CodeiumSuggestion", { fg = "#bcbfcb", italic = true })
  end,
}
