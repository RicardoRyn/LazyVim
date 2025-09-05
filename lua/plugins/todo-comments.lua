return {
  "folke/todo-comments.nvim",
  cond = not vim.g.vscode,
  opts = {
    keywords = {
      FIX = { color = "error" },
      TODO = { color = "todo" },
      HACK = { color = "warning" },
      WARN = { color = "warning" },
      PERF = { color = "perf" },
      TEST = { color = "info" },
      NOTE = { color = "hint" },
    },
    colors = {
      error = { "DiagnosticError", "ErrorMsg", "#DC2626" },
      todo = { "#f55e44" },
      warning = { "DiagnosticWarn", "WarningMsg" },
      perf = { "#6a2cbc" },
      info = { "DiagnosticInfo", "#2563EB" },
      hint = { "DiagnosticHint", "#10B981" },
    },
  },
}
