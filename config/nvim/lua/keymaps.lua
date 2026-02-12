local map = vim.keymap.set

-- 数値インクリメント(Ctrl-a)をCtrl-jに変更
-- 数値デクリメント(Ctrl-x)をCtrl-kに変更
map("n", "<C-j>", "<C-x>")
map("n", "<C-k>", "<C-a>")
map("n", "<C-x>", "<Nop>")

-- 行頭、行末移動をbashと同じに
map("n", "<C-a>", "0")
map("n", "<C-e>", "$")
map("i", "<C-a>", "<Home>")
map("i", "<C-e>", "<End>")

-- vertical diffsplit
map("n", "vd", ":vertical diffsplit ")

-- 選択範囲の小文字化/大文字化を無効化
map("v", "u", "<Nop>")
map("v", "U", "<Nop>")
