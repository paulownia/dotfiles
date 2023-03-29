vim.cmd('source ~/.vimrc')

require('nvim_comment').setup()

require("nvim-tree").setup()

vim.api.nvim_set_keymap("n", "T", ":NvimTreeToggle<CR>", { noremap = true })

