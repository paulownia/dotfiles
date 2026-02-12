return {
  { "nvim-tree/nvim-web-devicons" },
  {
    "nvim-tree/nvim-tree.lua",
    keys = {
      { "T", "<cmd>NvimTreeToggle<CR>", desc = "Toggle NvimTree" },
    },
    config = function()
      require("nvim-tree").setup()
    end,
  },
  {
    "EdenEast/nightfox.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      local C = require("nightfox.lib.color")

      require("nightfox").setup({
        options = {
          transparent = true,
        },
        groups = {
          carbonfox = {
            Pmenu = { bg = "#204148" },
            Visual = { bg = "#60626A" },
            Search = { bg = "#606032" },
            VertSplit = { bg = "#505050", fg = "#505050" },
            MatchParen = { fg = "#FF33FF", style = "reverse,bold" or "bold" },
          },
        },
        specs = {
          carbonfox = {
            diff = {
              add = C("#161616"):blend(C("#25BE6A"), 0.25):to_css(),
              delete = C("#161616"):blend(C("#EE5396"), 0.2):to_css(),
              change = C("#161616"):blend(C("#78A9FF"), 0.3):to_css(),
              text = "#5C03FE",
            },
          },
        },
      })

      vim.cmd.colorscheme("carbonfox")
    end,
  },
  {
    "nvim-lualine/lualine.nvim",
    config = function()
      local function progress()
        local cur = vim.fn.line(".")
        local total = vim.fn.line("$")
        local result
        if cur == total then
          result = 100
        elseif cur == 1 then
          result = 0
        else
          result = math.floor(cur / total * 100)
        end
        return string.format("%3s%%%%", result)
      end

      require("lualine").setup({
        options = {
          disabled_filetypes = { "NvimTree", "tagbar" },
          component_separators = { left = "|", right = "|" },
          section_separators = { left = "", right = "" },
        },
        sections = {
          lualine_b = { "branch", "diff" },
          lualine_c = {
            "filename",
            {
              "diagnostics",
              symbols = { error = " ", warn = " ", info = " " },
            },
          },
          lualine_y = { progress },
        },
      })
    end,
  },
}
