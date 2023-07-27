vim.cmd('source ~/.vimrc')

vim.opt.termguicolors = true
vim.opt.wildoptions = 'pum'
vim.opt.pumblend = 5

require('nvim_comment').setup()

require("nvim-tree").setup()

vim.api.nvim_set_keymap("n", "T", ":NvimTreeToggle<CR>", { noremap = true })


local C = require("nightfox.lib.color")

require('nightfox').setup({
  options = {
    transparent = true
  },
  groups = {
    carbonfox = {
      Pmenu = { bg = "#204148" },     -- 補完メニューなど
      Visual = { bg = "#60626A" },    -- v-modeでの選択範囲
      Search = { bg = "#606032" },    -- 検索結果
      VertSplit = { bg = "#505050", fg = "#505050" },    -- ウィンドウ分割時の縦線 `|`
    }
  },
  specs = {
    carbonfox = {
      diff = {
        add = C("#161616"):blend(C("#25BE6A"), 0.25):to_css(),
        delete = C("#161616"):blend(C("#EE5396"), 0.2):to_css(),
        change = C("#161616"):blend(C("#78A9FF"), 0.3):to_css(),
        text = "#5C03FE",
      }
    }
  }
});

vim.cmd.colorscheme "carbonfox"

local function progress()
  local cur = vim.fn.line('.')
  local total = vim.fn.line('$')
  local result
  if cur == total then
    result = 100
  elseif cur == 1 then
    result = 0
  else
    result = math.floor(cur / total * 100)
  end

  return string.format('%3s%%%%', result)
end


require('lualine').setup({
  options = {
    disabled_filetypes = {'NvimTree', 'tagbar'},
    component_separators = { left = '|', right = '|'},
    section_separators = { left = '', right = ''},
  },
  sections = {
    lualine_y = { progress },
  },
})
