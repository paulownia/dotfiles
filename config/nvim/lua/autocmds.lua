local augroup = vim.api.nvim_create_augroup("vimrc", { clear = true })

-- auto trim trailing whitespace
local trim_exclude = { markdown = true, diff = true }
vim.api.nvim_create_autocmd("BufWritePre", {
  group = augroup,
  pattern = "*",
  callback = function()
    if trim_exclude[vim.bo.filetype] then
      return
    end
    local pos = vim.api.nvim_win_get_cursor(0)
    vim.cmd([[%s/\s\+$//ge]])
    vim.api.nvim_win_set_cursor(0, pos)
  end,
})

-- mapping typo commands
vim.api.nvim_create_user_command("Q", "q<bang>", { bang = true })
vim.api.nvim_create_user_command("W", "w<bang>", { bang = true })
vim.api.nvim_create_user_command("Wq", "wq<bang>", { bang = true })
vim.api.nvim_create_user_command("WQ", "wq<bang>", { bang = true })
