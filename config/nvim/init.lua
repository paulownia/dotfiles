vim.cmd('source ~/.vimrc')

--[[
require('kommentary.config').use_extended_mappings()
vim.api.nvim_set_keymap("n", "gcc", "<Plug>kommentary_line_default", {})
vim.api.nvim_set_keymap("n", "gc", "<Plug>kommentary_motion_default", {})
vim.api.nvim_set_keymap("v", "gc", "<Plug>kommentary_visual_default<C-c>", {})
]]--

require('nvim_comment').setup()
