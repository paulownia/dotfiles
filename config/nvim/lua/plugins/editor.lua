return {
  { "mattn/emmet-vim" },
  { "tpope/vim-fugitive" },
  {
    "preservim/tagbar",
    keys = {
      { "t", "<cmd>TagbarToggle<CR>", desc = "Toggle Tagbar" },
    },
    config = function()
      vim.g.tagbar_type_javascript = {
        ctagtype = "JavaScript",
        kinds = { "c:classes", "m:methods", "f:functions", "t:testcase", "d:describe" },
      }
      vim.g.tagbar_type_go = {
        ctagstype = "go",
        kinds = {
          "p:package", "i:imports:1", "c:constants", "v:variables",
          "t:types", "n:interfaces", "w:fields", "e:embedded",
          "m:methods", "r:constructor", "f:functions",
        },
        sro = ".",
        kind2scope = { t = "ctype", n = "ntype" },
        scope2kind = { ctype = "t", ntype = "n" },
        ctagsbin = "gotags",
        ctagsargs = "-sort -silent",
      }
    end,
  },
  { "kien/ctrlp.vim" },
  { "AndrewRadev/switch.vim" },
  { "vim-scripts/sudo.vim" },
  { "github/copilot.vim" },
}
