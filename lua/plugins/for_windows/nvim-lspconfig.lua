return {
  "neovim/nvim-lspconfig",
  cond = function()
    return vim.loop.os_uname().sysname == "Windows_NT" and not vim.g.vscode
  end,
  opts = {
    servers = {
      lua_ls = {
        -- 自定义 workspace 根目录
        root_dir = function(fname)
          return require("lspconfig.util").root_pattern(
            ".git",
            "init.lua",
            ".luarc.json",
            ".luarc.jsonc",
            ".luacheckrc",
            ".stylua.toml",
            "stylua.toml",
            "selene.toml",
            "selene.yml"
          )(fname) or vim.fn.getcwd()
        end,
        settings = {
          Lua = {
            diagnostics = { globals = { "vim" } },
            workspace = {
              checkThirdParty = false,
              library = {
                vim.env.VIMRUNTIME,
                vim.fn.stdpath("config") .. "/lua",
              },
            },
            telemetry = { enable = false },
          },
        },
        on_attach = function(client, bufnr)
          -- 如果不想让 LSP 自动格式化
          client.server_capabilities.documentFormattingProvider = false
          client.server_capabilities.documentRangeFormattingProvider = false
        end,
      },
    },
  },
  keys = {
    { "<leader>r", "<cmd>LspRestart<cr>", desc = "Restart LSP" }
  }
}
