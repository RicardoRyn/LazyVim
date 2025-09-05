return {
  "nvim-neo-tree/neo-tree.nvim",
  cond = not vim.g.vscode,
  -- stylua: ignore
  keys = {
    { "<leader>e",
      function() require("neo-tree.command").execute({ toggle = true, dir = vim.uv.cwd() }) end,
      desc = "NeoTree (cwd)",
    },
    { "<leader>ge",
      function() require("neo-tree.command").execute({ source = "git_status", toggle = true }) end,
      desc = "Git Explorer",
    },
    { "<leader>be",
      function() require("neo-tree.command").execute({ source = "buffers", toggle = true }) end,
      desc = "Buffer Explorer",
    },
  },
  opts = {
    window = {
      mappings = {
        ["l"] = "open",
        ["h"] = "close_node",
        ["<space>"] = "none",
        ["t"] = "none",
        ["c"] = "none",
        ["cc"] = {
          function(state)
            local node = state.tree:get_node()
            local path = node:get_id()
            vim.fn.setreg("+", path, "c")
          end,
          desc = "Copy Path to Clipboard",
        },
        ["cd"] = {
          function(state)
            local node = state.tree:get_node()
            local path = node:get_id()
            local dir = vim.fn.fnamemodify(path, ":h") -- 获取目录部分
            vim.fn.setreg("+", dir, "c") -- 复制到系统剪贴板
          end,
          desc = "Copy Directory Path to Clipboard",
        },
        ["cf"] = {
          function(state)
            local node = state.tree:get_node()
            local path = node:get_id()
            local name = vim.fn.fnamemodify(path, ":t")
            vim.fn.setreg("+", name, "c")
            -- 可选提示
            -- vim.notify("Copied name: " .. name)
          end,
          desc = "Copy File/Dir Name to Clipboard",
        },
        ["o"] = "open",
        ["O"] = {
          function(state)
            require("lazy.util").open(state.tree:get_node().path, { system = true })
          end,
          desc = "Open with System Application",
        },
        ["oc"] = "none",
        ["od"] = "none",
        ["og"] = "none",
        ["om"] = "none",
        ["on"] = "none",
        ["os"] = "none",
        ["ot"] = "none",
        [","] = "none",
        [",c"] = "order_by_created",
        [",d"] = "order_by_diagnostics",
        [",g"] = "order_by_git_status",
        [",m"] = "order_by_modified",
        [",n"] = "order_by_name",
        [",s"] = "order_by_size",
        [",t"] = "order_by_type",
        ["P"] = { "toggle_preview", config = { use_float = false } },
      },
    },
  },
  config = function(_, opts)
    require("neo-tree").setup(opts)
    -- 设置 NeoTree 当前行颜色为灰色
    vim.api.nvim_set_hl(0, "NeoTreeCursorLine", { bg = "#dce0e8" })
  end,
}
