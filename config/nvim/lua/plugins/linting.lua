return {
  {
    "dense-analysis/ale",
    config = function()
      vim.keymap.set("n", "]w", "<Plug>(ale_next_wrap)", { silent = true })
      vim.keymap.set("n", "[w", "<Plug>(ale_previous_wrap)", { silent = true })

      vim.g.ale_linters = {
        javascript = { "eslint" },
        json = { "jsonlint" },
        ruby = { "rubocop" },
        html = { "htmlhint" },
        css = { "stylelint" },
        ansible = { "ansible_lint" },
        yaml = { "yamllint" },
        rust = { "cargo" },
      }

      vim.g.ale_ruby_rubocop_executable = "bundle"
      vim.g.ale_ruby_rubocop_options = ""
      vim.g.ale_lint_delay = 1500

      vim.api.nvim_set_hl(0, "ALEError", { underline = true, bold = true })
      vim.api.nvim_set_hl(0, "ALEWarning", { underline = true })
      vim.api.nvim_set_hl(0, "ALEErrorSign", { fg = "#ff3333", bg = "#606060" })
      vim.api.nvim_set_hl(0, "ALEWarningSign", { fg = "#ffff33", bg = "#606060" })
    end,
  },
}
