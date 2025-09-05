-- PERF: master分支的treesitter，不再维护
return {
  "nvim-treesitter/nvim-treesitter",
  cond = not vim.g.vscode,
  dependencies = { "nvim-treesitter/nvim-treesitter-textobjects" },
  opts = {
    -- jupyter notebook相关
    textobjects = {
      move = {
        enable = true,
        set_jumps = false, -- you can change this if you want.
        goto_next_start = {
          ["]c"] = { query = "@code_cell.inner", desc = "Next Code Block" },
        },
        goto_next_end = {
          ["]C"] = { query = "@code_cell.inner", desc = "Next Code Block" },
          ["gl"] = { query = "@code_cell.inner", desc = "Cell End" },
        },
        goto_previous_start = {
          ["[c"] = { query = "@code_cell.inner", desc = "Previous Code Block" },
          ["gh"] = { query = "@code_cell.inner", desc = "Cell Start" },
        },
      },
      select = {
        enable = true,
        lookahead = true, -- you can change this if you want
        keymaps = {
          ["ic"] = { query = "@code_cell.inner", desc = "in block" },
          ["ac"] = { query = "@code_cell.outer", desc = "around block" },
        },
      },
      swap = { -- Swap only works with code blocks that are under the same
        -- markdown header
        enable = true,
        swap_next = { ["<leader>msl"] = "@code_cell.outer" },
        swap_previous = { ["<leader>msh"] = "@code_cell.outer" },
      },
    },
  },
  config = function(_, opts)
    require("nvim-treesitter.configs").setup(opts)
    -- HACK: 先向上移动一行，再使用[C可以稳定跳转到上一个cell的末尾
    local textobj_move = require("nvim-treesitter.textobjects.move")
    local function previous_code_block()
      vim.api.nvim_command("normal! k")
      textobj_move.goto_previous_end("@code_cell.inner")
    end
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "markdown",
      callback = function()
        vim.keymap.set("n", "[C", previous_code_block, {
          desc = "Previous Code Block (stable)",
        })
      end,
    })
  end,
}
