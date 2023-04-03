vim.cmd('source ~/.vimrc')

vim.opt.termguicolors = true
vim.opt.wildoptions = 'pum'
vim.opt.pumblend = 5

require('nvim_comment').setup()

require("nvim-tree").setup()

vim.api.nvim_set_keymap("n", "T", ":NvimTreeToggle<CR>", { noremap = true })

require('nightfox').setup({
  options = {
    transparent = true
  },
  groups = {
    all = {
      Pmenu = { bg = "#204148" },     -- 補完メニューなど
      Visual = { bg = "#60626A" },    -- v-modeでの選択範囲
      Search = { bg = "#606032" },    -- 検索結果
      VertSplit = { bg = "#505050", fg = "#505050" },    -- ウィンドウ分割時の縦線 `|`
    }
  },
});

vim.cmd.colorscheme "carbonfox"

require('lualine').setup({
  options = {
    disabled_filetypes = {'NvimTree', 'tagbar'}
  }
})
