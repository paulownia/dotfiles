-- lazy.nvim bootstrap
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("options")
require("keymaps")
require("autocmds")
require("filetypes")

require("lazy").setup("plugins", {
  rocks = { enabled = false },
})

-- vimdiff color (termguicolors用)
vim.api.nvim_set_hl(0, "DiffAdd", { bg = "#002800" })
vim.api.nvim_set_hl(0, "DiffDelete", { bg = "#280000" })
vim.api.nvim_set_hl(0, "DiffChange", { bg = "#002828" })
vim.api.nvim_set_hl(0, "DiffText", { bg = "#280028" })

-- ローカルオーバーライド
local local_config = vim.fn.expand("~/.config/nvim_local.lua")
if vim.fn.filereadable(local_config) == 1 then
  dofile(local_config)
end
