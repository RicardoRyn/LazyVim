-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
-- NOTE: Neovim和Vscode都生效的设置
vim.keymap.set("n", "<leader>h", "<cmd>:noh<cr>", { desc = "Clear Highlight" })
vim.keymap.set("v", "<", "<gv", { desc = "Outdent and reselect" })
vim.keymap.set("v", ">", ">gv", { desc = "Indent and reselect" })
vim.keymap.set({ "v" }, "U", "<Nop>")
vim.keymap.set({ "v" }, "u", "<Nop>")

-- hop必须写在这，否这刚打开vim的时候用不了快捷键
local hop = require("hop")
local directions = require("hop.hint").HintDirection
local positions = require("hop.hint").HintPosition
hop.setup({}) -- 初始化插件

vim.keymap.set({ "n", "v" }, "<leader><leader>j", function()
  hop.hint_lines({ direction = directions.AFTER_CURSOR })
end, { desc = "Go to line below" })

vim.keymap.set({ "n", "v" }, "<leader><leader>k", function()
  hop.hint_lines({ direction = directions.BEFORE_CURSOR })
end, { desc = "Go to line above" })

vim.keymap.set({ "n", "v" }, "<leader><leader>l", function()
  hop.hint_camel_case({ direction = directions.AFTER_CURSOR })
end, { desc = "Go to next any begining of words" })

vim.keymap.set({ "n", "v" }, "<leader><leader>h", function()
  hop.hint_camel_case({ direction = directions.BEFORE_CURSOR })
end, { desc = "Go to previous any begining of words" })


-- stylua: ignore
if vim.g.vscode then
  -- NOTE: Vscode中生效的设置
  -- general
  vim.keymap.set( "n", "<leader>ff", "<Cmd>lua require('vscode').call('workbench.action.quickOpenWithModes')<CR>", { desc = "Find Files" })
  vim.keymap.set( "n", "<leader>uz", "<Cmd>lua require('vscode').call('workbench.action.toggleZenMode')<CR>", { desc = "Zen Mode" })
  vim.keymap.set( "n", "<leader>oo", "<Cmd>lua require('vscode').call('outline.focus')<CR>", { desc = "Outline" })
  vim.keymap.set( "n", "<leader>ov", "<Cmd>lua require('vscode').call('outline.toggleVisibility')<CR>", { desc = "Outline Visibility" })
  -- 以下两项既需要在此处设置，也需要在vscode的快捷键中设置
  vim.keymap.set( "n", "<C-h>", "<Cmd>lua require('vscode').call('workbench.action.navigateLeft')<CR>", { desc = "Move to left window" })
  vim.keymap.set( "n", "<C-l>", "<Cmd>lua require('vscode').call('workbench.action.navigateRight')<CR>", { desc = "Move to right window" })

  -- Code
  vim.api.nvim_exec2("nmap j gj", { output = false })
  vim.api.nvim_exec2("nmap k gk", { output = false })
  vim.keymap.set("n", "u", "<Cmd>lua require('vscode').call('undo')<CR>", { desc = "Undo" })
  vim.keymap.set("n", "<C-r>", "<Cmd>lua require('vscode').call('redo')<CR>", { desc = "Redo" })
  vim.keymap.set( "v", "<leader>cf", "<Cmd>lua require('vscode').call('editor.action.formatSelection')<CR>", { desc = "format selection" })
  vim.keymap.set( "n", "<leader>cf", "<Cmd>lua require('vscode').call('editor.action.formatDocument')<CR>", { desc = "format selection" })
  vim.keymap.set( "n", "<leader>cr", "<Cmd>lua require('vscode').call('editor.action.rename')<CR>", { desc = "rename symbol" })
  vim.keymap.set( "n", "]d", "<Cmd>lua require('vscode').call('editor.action.marker.next')<CR>", { desc = "Go to next diagnostic" })
  vim.keymap.set( "n", "[d", "<Cmd>lua require('vscode').call('editor.action.marker.prev')<CR>", { desc = "Go to previous diagnostic" })
  vim.keymap.set("n", "<leader>oo", "<Cmd>lua require('vscode').call('outline.focus')<CR>", { desc = "open outline" })
  vim.keymap.set("n", "za", "<Cmd>lua require('vscode').call('editor.toggleFold')<CR>", { desc = "Toggle fold" })

  -- Buffer
  vim.keymap.set( "n", "L", "<Cmd>lua require('vscode').call('workbench.action.nextEditor')<CR>", { desc = "Next buffer" })
  vim.keymap.set( "n", "H", "<Cmd>lua require('vscode').call('workbench.action.previousEditor')<CR>", { desc = "Prev buffer" })
  vim.keymap.set( "n", "<leader>bd", "<Cmd>lua require('vscode').call('workbench.action.closeActiveEditor')<CR>", { desc = "close buffer (VSCode)" })
  vim.keymap.set( "n", "<leader>bo", "<Cmd>lua require('vscode').call('workbench.action.closeOtherEditors')<CR>", { desc = "close other buffers (VSCode)" })
  vim.keymap.set( "n", "<leader>bl", "<Cmd>lua require('vscode').call('workbench.action.closeEditorsToTheLeft')<CR>", { desc = "close buffers to the left (VSCode)" })
  vim.keymap.set( "n", "<leader>br", "<Cmd>lua require('vscode').call('workbench.action.closeEditorsToTheRight')<CR>", { desc = "close buffers to the right (VSCode)" })
  vim.keymap.set( "n", "<leader>ba", "<Cmd>lua require('vscode').call('workbench.action.closeAllEditors')<CR>", { desc = "close all buffers (VSCode)" })
  vim.keymap.set( "n", "<leader>b<", "<Cmd>lua require('vscode').call('workbench.action.moveEditorLeftInGroup')<CR>", { desc = "Move buffer left (VSCode)" })
  vim.keymap.set( "n", "<leader>b>", "<Cmd>lua require('vscode').call('workbench.action.moveEditorRightInGroup')<CR>", { desc = "Move buffer right (VSCode)" })

  -- UI
  vim.keymap.set( "n", "<leader>e", "<Cmd>lua require('vscode').call('workbench.action.toggleSidebarVisibility')<CR>", { desc = "toggleSidebarVisibility" })
  vim.keymap.set("n", "<leader>E", "<Cmd>lua require('vscode').call('yazi-vscode.toggle')<CR>", { desc = "open yazi" })
  vim.keymap.set( "n", "<leader>a", "<Cmd>lua require('vscode').call('workbench.action.toggleActivityBarVisibility')<CR>", { desc = "toggleActivityBarVisibility" })

else
  -- NOTE: Neovim中生效的设置
  -- 禁用LazyVim的部分快捷键
  vim.keymap.del("n", "<leader>qd")
  vim.keymap.del("n", "<leader>ql")
  vim.keymap.del("n", "<leader>qq")
  vim.keymap.del("n", "<leader>qs")
  vim.keymap.del("n", "<leader>qS")

  vim.keymap.set({ "i" }, "jk", "<Esc>")
  -- vim.keymap.set("n", "j", "gj", { desc = "gj" })
  -- vim.keymap.set("n", "k", "gk", { desc = "gk" })
  vim.keymap.set("n", "gj", "j", { desc = "j" })
  vim.keymap.set("n", "gk", "k", { desc = "k" })

  -- Copy
  vim.keymap.set("v", "<C-c>", '"+y') -- 让neovim中C-c可以复制内容到剪贴板
  vim.keymap.set("i", "<C-v>", "<C-r>+", { noremap = true, silent = true, desc = "Paste from clipboard in insert mode" })

  -- 由smart-splits.lua接管
  -- vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Go to Left Window", remap = true })
  -- vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Go to Lower Window", remap = true })
  -- vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Go to Upper Window", remap = true })
  -- vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Go to Right Window", remap = true })
end

-- NOTE: Neovide中生效的设置
if vim.g.neovide then
  vim.keymap.set({ "n", "v", "s", "x", "o", "i", "l", "c", "t" }, "<C-S-v>", function()
    vim.api.nvim_paste(vim.fn.getreg("+"), true, -1)
  end, { noremap = true, silent = true })
end
