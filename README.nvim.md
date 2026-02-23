
# Neovim ガイド

## Neovim ディレクトリ構成

```
config/nvim/
├── init.lua                    -- エントリポイント（lazy.nvim bootstrap + require）
├── lua/
│   ├── options.lua             -- vim.opt 設定
│   ├── keymaps.lua             -- キーマッピング
│   ├── autocmds.lua            -- autocmd + typoコマンド（Q, W, Wq, WQ）
│   ├── filetypes.lua           -- vim.filetype.add()（ftdetect統合）
│   └── plugins/
│       ├── editor.lua          -- emmet, fugitive, tagbar, ctrlp, switch, sudo, copilot
│       ├── linting.lua         -- ale + highlight設定
│       ├── runner.lua          -- vim-quickrun
│       ├── languages.lua       -- typescript-vim, vim-javascript, vim-jsdoc, vim-svelte, vim-rails
│       ├── ui.lua              -- nightfox, lualine, nvim-tree, nvim-web-devicons
│       └── comment.lua         -- nvim-comment
├── ftplugin/                   -- ファイルタイプ別設定（Lua）
│   ├── gitcommit.lua
│   ├── go.lua
│   ├── html.lua
│   ├── java.lua
│   ├── json.lua
│   ├── nginx.lua
│   ├── php.lua
│   ├── sh.lua
│   └── zsh.lua
└── after/
    └── syntax/
        └── css.vim             -- CSS syntax拡張
```

プラグイン管理は [lazy.nvim](https://github.com/folke/lazy.nvim)。ローカルオーバーライドは `~/.config/nvim/local.lua` に記述（`local.lua.example` をコピーして使う）。

## プラグイン管理

### プラグインの更新

Neovim 内で以下のコマンドを実行:

    :Lazy update

全プラグインが最新版に更新される。更新後 `lazy-lock.json` が書き換わるが、`.gitignore` で除外済み。

### プラグインの追加

`lua/plugins/` 内の適切なファイルに spec を追加する。

例: [vim-surround](https://github.com/tpope/vim-surround) を追加する場合、`lua/plugins/editor.lua` の return テーブルに追記:

```lua
return {
  -- 既存のプラグイン...
  { "tpope/vim-surround" },
}
```

Neovim を再起動すると lazy.nvim が自動的にインストールする。

設定が必要なプラグインの場合:

```lua
{
  "author/plugin-name",
  config = function()
    require("plugin-name").setup({
      -- オプション
    })
  end,
}
```

遅延読み込みを使う場合は `ft`, `cmd`, `keys`, `event` で条件を指定:

```lua
{ "author/plugin-name", ft = "markdown" }          -- filetypeで遅延
{ "author/plugin-name", cmd = "PluginCommand" }     -- コマンドで遅延
{ "author/plugin-name", keys = { "<leader>p" } }    -- キーマップで遅延
```

### lazy.nvim 自体の更新

    :Lazy sync

`sync` はプラグインの更新に加え、lazy.nvim 本体も最新の stable に更新する。

### トラブルシューティング

プラグインの追加・更新後に不具合が発生した場合は `:checkhealth` を実行して診断する。依存ツールの不足やバージョン不整合を検出できる。特定のプラグインだけを確認する場合:

    :checkhealth nvim-treesitter
