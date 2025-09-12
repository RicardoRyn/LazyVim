-- 安装gh
-- gh auth login
-- gh extension install meiji163/gh-notify
-- 由于Windows上类Unix脚本的Shebang路径问题，可能需要修改gh-notify的脚本
return {
  "folke/snacks.nvim",
  cond = not vim.g.vscode,
  opts = {
    indent = { enabled = true, indent = { char = "▏" }, scope = { char = "▍", hl = "" } },
    notifier = { enabled = true, timeout = 3000 },
  },
  keys = {
    { '<leader>D', function() Snacks.dashboard() end, desc = "Dashboard" },
    { '<leader><space>', "<Nop>" },
    { '<leader>s.', function() Snacks.scratch.select() end, desc = "Scratch" },
    { '<leader>S', "<Nop>" },
    { "<leader>sc", function() Snacks.picker.commands() end, desc = "Commands" },
  }
}
