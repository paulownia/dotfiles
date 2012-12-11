" ライン番号
set number

" インデント
" set autoindent
" set smartindent
" set cindent

" タブ幅（基本設定、言語別設定はftpluginで）
set tabstop=4
set softtabstop=4
set shiftwidth=4

" 折り返ししない
set nolinebreak
set nowrap

" ステータス行
set laststatus=2

" 検索結果をハイライト
set hlsearch

" シンタックスハイライト
syntax on

" ファイルタイプ別プラグインを有効に
filetype on
filetype indent on
filetype plugin on

" インサートモードからノーマルモードへの変換をCtrl-Spaceで
inoremap <Nul> <ESC>

" 数値インクリメント(Ctrl-a)をCtrl-kに変更
" 数値デクリメント(Ctrl-x)をCtrl-jに変更
nnoremap <C-j> <C-a>
nnoremap <C-k> <C-x>

" 行頭、行末移動をbashと同じに
nnoremap <C-a> 0
nnoremap <C-e> $
 
inoremap <C-a> <Home>
inoremap <C-e> <End>


" CJK記号の幅調整
set ambiwidth=double

" 文法で折りたたみ
set foldmethod=syntax

" zen coding キーパイント変更
let g:user_zen_expandabbr_key = '<C-y>'

" Tagbar
nnoremap t :TagbarToggle<CR>

" Unite
nnoremap UM :Unite file_mru<CR>
nnoremap UB :Unite buffer<CR>
nnoremap UF :Unite file<CR>
nnoremap UR :Unite file_rec<CR>

