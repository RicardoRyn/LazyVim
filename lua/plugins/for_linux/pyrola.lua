return {
  "matarina/pyrola.nvim",
  enabled = false,
  cond = function()
    return vim.loop.os_uname().sysname == "Linux" and not vim.g.vscode
  end,
  dependencies = { "nvim-treesitter/nvim-treesitter" },
  build = ":UpdateRemotePlugins",
  config = function(_, opts)
    local pyrola = require("pyrola")
    pyrola.setup({
      kernel_map = { -- Map Jupyter kernel names to Neovim filetypes
        python = "python3",
        r = "ir",
        cpp = "xcpp14",
      },
      split_horizen = false, -- Define the terminal split direction
      split_ratio = 0.3, -- Set the terminal split size
    })

    -- Define key mappings for enhanced functionality
    vim.keymap.set("n", "<Enter>", function()
      pyrola.send_statement_definition()
    end, { noremap = true })

    vim.keymap.set("v", "<leader>vs", function()
      require("pyrola").send_visual_to_repl()
    end, { noremap = true })

    vim.keymap.set("n", "<leader>is", function()
      pyrola.inspect()
    end, { noremap = true })

    -- Configure Treesitter for enhanced code parsing
    require("nvim-treesitter.configs").setup({
      ensure_installed = { "cpp", "r", "python" }, -- Ensure the necessary Treesitter language parsers are installed
      auto_install = true,
    })
  end,
  init = function ()
    vim.env.PATH = vim.fn.expand("~/miniforge3/envs/neovim/bin") .. ":" .. vim.env.PATH -- 保证neovim环境中的jupytext可用
    vim.g.python3_host_prog = vim.fn.expand("~/miniforge3/envs/neovim/bin/python3")
  end
}
