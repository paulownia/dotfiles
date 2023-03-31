vim.cmd('source ~/.vimrc')

vim.opt.termguicolors = true
vim.opt.wildoptions = 'pum'
vim.opt.pumblend = 10

require('nvim_comment').setup()

require("nvim-tree").setup()

vim.api.nvim_set_keymap("n", "T", ":NvimTreeToggle<CR>", { noremap = true })

require('nightfox').setup({
  options = {
    transparent = true
  },
  groups = {
    all = {
      Visual = { bg = "#60626A" },
      Search = { bg = "#606032" },
      VertSplit = { bg = "#505050", fg = "#505050" }
    }
  },
});

vim.cmd.colorscheme "carbonfox"

require('lualine').setup({
  options = {
    disabled_filetypes = {'NvimTree', 'tagbar'}
  }
})
