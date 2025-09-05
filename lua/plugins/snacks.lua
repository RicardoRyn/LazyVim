-- 安装gh
-- gh auth login
-- gh extension install meiji163/gh-notify
-- 由于Windows上类Unix脚本的Shebang路径问题，可能需要修改gh-notify的脚本
return {
  "folke/snacks.nvim",
  cond = not vim.g.vscode,
  opts = {
    dashboard = {
      enabled = true,
      preset = {
        -- stylua: ignore
        keys = {
          { icon = " ", key = "s", desc = "Session", section = "session" },
          { icon = " ", key = "f", desc = "Find Files", action = ":lua Snacks.dashboard.pick('files')" },
          { icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
          { icon = " ", key = "p", desc = "Projects", action = ":lua Snacks.dashboard.pick('projects')" },
          { icon = " ", key = "w", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
          { icon = " ", key = "c", desc = "Config", action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})", },
          { icon = " ", key = "b", desc = "Browse Repo", action = ":lua Snacks.gitbrowse()", },
          { icon = "󰒲 ", key = "L", desc = "Lazy", action = ":Lazy", enabled = package.loaded.lazy ~= nil },
          { icon = " ", key = "q", desc = "Quit", action = ":qa" },

        },
      },
      sections = {
        { section = "header" },
        { icon = " ", title = "Keymaps", section = "keys", indent = 2, padding = 1 },
        { icon = " ", title = "Recent Files", section = "recent_files", indent = 2, padding = 1 },
        { icon = " ", title = "Projects", section = "projects", indent = 2, padding = 1 },
        { section = "startup" },
      },
    },
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
