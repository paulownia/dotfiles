-- スクロール
vim.opt.scrolloff = 4

-- タブ幅
vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2

-- スワップファイル、バックアップを作らない
vim.opt.backup = false
vim.opt.swapfile = false
vim.opt.writebackup = false

-- ステータス行(3 = グローバルステータスラインを使う)
vim.opt.laststatus = 3

-- 折り返し表示オプション
vim.opt.linebreak = true
vim.opt.showbreak = ">"
vim.opt.breakindent = true
vim.opt.breakindentopt = "shift:6,sbr"

-- 絵文字を全角幅で表示
vim.opt.emoji = true

-- 検索
-- vim.opt.hlsearch = true  -- nvimデフォルト
vim.opt.ignorecase = true
vim.opt.smartcase = true
-- vim.opt.incsearch = true  -- nvimデフォルト

-- コマンド補完
vim.opt.wildmode = "longest:full,full"

-- yankをclipboardへ
vim.opt.clipboard = "unnamedplus"

-- diffopt追加、デフォルト縦分割にする
vim.opt.diffopt:append("vertical")

-- conceal
vim.opt.conceallevel = 2
vim.opt.concealcursor = "nvc"

-- termguicolors
vim.opt.termguicolors = true

-- wildoptions
vim.opt.wildoptions = "pum"

-- pumblend
vim.opt.pumblend = 5

-- editorconfig
vim.g.editorconfig = true

-- 未使用プロバイダを無効化
vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0
