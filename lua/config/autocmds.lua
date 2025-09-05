-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")
local function augroup(name)
  return vim.api.nvim_create_augroup("ricardo_" .. name, { clear = true })
end

-- 在python和lua文件中，使用`o`和`O`时不会自动添加注释符号
vim.api.nvim_create_autocmd("FileType", {
  group = augroup("disable_o_comment"),
  pattern = { "python", "lua" },
  callback = function()
    vim.opt.formatoptions:remove({ "o" })
  end,
})
