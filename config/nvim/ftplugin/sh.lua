vim.opt_local.expandtab = false
vim.opt_local.softtabstop = 4
vim.opt_local.shiftwidth = 4
vim.opt_local.tabstop = 4

vim.api.nvim_create_autocmd("BufEnter", {
  pattern = ".env*",
  callback = function()
    vim.cmd("ALEDisable")
    vim.b.copilot_enabled = false
  end,
})
