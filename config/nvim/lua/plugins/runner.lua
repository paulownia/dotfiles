return {
  {
    "thinca/vim-quickrun",
    cmd = "QuickRun",
    config = function()
      vim.g.quickrun_config = {
        typescript = { exec = "bun run %s" },
        python = { exec = "python3 %s" },
        _ = {
          ["outputter/buffer/split"] = ":botright 12sp",
          ["outputter/buffer/close_on_empty"] = 1,
        },
      }
    end,
  },
}
