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

if not vim.g.vscode then
  -- automatically import output chunks from a jupyter notebook
  -- tries to find a kernel that matches the kernel in the jupyter notebook
  -- falls back to a kernel that matches the name of the active venv (if any)

  -- 定义 imb 函数：初始化 molten buffer
  local imb = function(e) -- init molten buffer
    vim.schedule(function()
      local kernels = vim.fn.MoltenAvailableKernels()
      local try_kernel_name = function()
        local metadata = vim.json.decode(io.open(e.file, "r"):read("a"))["metadata"]
        return metadata.kernelspec.name
      end
      local ok, kernel_name = pcall(try_kernel_name)
      if not ok or not vim.tbl_contains(kernels, kernel_name) then
        kernel_name = nil
        local venv = os.getenv("VIRTUAL_ENV") or os.getenv("CONDA_PREFIX")
        if venv ~= nil then
          kernel_name = string.match(venv, "/.+/(.+)")
        end
      end
      if kernel_name ~= nil and vim.tbl_contains(kernels, kernel_name) then
        vim.cmd(("MoltenInit %s"):format(kernel_name))
      end
      vim.cmd("MoltenImportOutput")
    end)
  end
  -- 自动导入输出
  -- automatically import output chunks from a jupyter notebook
  vim.api.nvim_create_autocmd("BufAdd", {
    pattern = { "*.ipynb" },
    callback = imb,
  })
  -- we have to do this as well so that we catch files opened like nvim ./hi.ipynb
  vim.api.nvim_create_autocmd("BufEnter", {
    pattern = { "*.ipynb" },
    callback = function(e)
      if vim.api.nvim_get_vvar("vim_did_enter") ~= 1 then
        imb(e)
      end
    end,
  })
  -- 自动导出输出
  -- automatically export output chunks to a jupyter notebook on write
  vim.api.nvim_create_autocmd("BufWritePost", {
    pattern = { "*.ipynb" },
    callback = function()
      if require("molten.status").initialized() == "Molten" then
        vim.cmd("MoltenExportOutput!")
      end
    end,
  })

  -- 当你打开 .py 文件时，Molten 的虚拟行（virt_lines_off_by_1）和虚拟文本输出（virt_text_output）都会 关闭，避免 Python 代码文件里出现执行输出的虚拟行/文本（因为可能会干扰正常代码阅读）。
  vim.api.nvim_create_autocmd("BufEnter", {
    pattern = "*.py",
    callback = function(e)
      if string.match(e.file, ".otter.") then
        return
      end
      if require("molten.status").initialized() == "Molten" then -- this is kinda a hack...
        vim.fn.MoltenUpdateOption("virt_lines_off_by_1", false)
        vim.fn.MoltenUpdateOption("virt_text_output", false)
      else
        vim.g.molten_virt_lines_off_by_1 = false
        vim.g.molten_virt_text_output = false
      end
    end,
  })
  -- 当你返回 .qmd、.md、.ipynb 文件时，这两个选项会 开启，这样在文档里就能直接看到代码执行的输出（Molten 会用虚拟行和虚拟文本把结果插在代码下面）。
  vim.api.nvim_create_autocmd("BufEnter", {
    pattern = { "*.qmd", "*.md", "*.ipynb" },
    callback = function(e)
      if string.match(e.file, ".otter.") then
        return
      end
      if require("molten.status").initialized() == "Molten" then
        vim.fn.MoltenUpdateOption("virt_lines_off_by_1", true)
        vim.fn.MoltenUpdateOption("virt_text_output", true)
      else
        vim.g.molten_virt_lines_off_by_1 = true
        vim.g.molten_virt_text_output = true
      end
    end,
  })
end
