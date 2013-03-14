" vundle
set nocompatible
filetype off
set rtp+=~/.vim/vundle.git/
call vundle#rc()

Bundle 'scrooloose/syntastic'
Bundle 'ZenCoding.vim'
Bundle 'unite.vim'
Bundle 'tpope/vim-fugitive'
Bundle 'othree/html5-syntax.vim'
Bundle 'majutsushi/tagbar'
Bundle 'tpope/vim-rails'
Bundle 'dag/vim2hs'
Bundle 'jQuery'
Bundle 'nginx.vim'
Bundle 'kien/ctrlp.vim'
Bundle 'leafgarland/typescript-vim'
Bundle 'thinca/vim-quickrun'

filetype on


" ライン番号
" set number

" タブ幅
set tabstop=4
set softtabstop=4
set shiftwidth=4

" 折り返ししない
set nolinebreak
set nowrap

" スワップファイル、バックアップを作らない
set nobackup
set noswapfile

" ステータス行
set laststatus=2
set statusline=%f%m%r%h%w\ %{fugitive#statusline()}\ (%Y)%=\ %l/%L

" 検索結果をハイライト
set hlsearch

" コマンド補完
set wildmenu

" CJK記号の幅調整
set ambiwidth=double

" 文法で折りたたみ
set foldmethod=syntax

" カーソルに下線
set cursorline


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

" Tagbar
nnoremap t :TagbarToggle<CR>

" Unite
nnoremap UM :Unite file_mru<CR>
nnoremap UB :Unite buffer<CR>
nnoremap UF :Unite file<CR>
nnoremap UR :Unite file_rec<CR>

" zen coding キーパイント変更
let g:user_zen_expandabbr_key = '<C-y>'

" syntasticでjshintを使う
let g:syntastic_javascript_checkers = ['jshint']
let g:syntastic_auto_loc_list = 1

" QuickRun設定
let g:quickrun_config = {}
" 結果を上下分割で表示
let g:quickrun_config._ = { 'split': '' }

" tagbar javascript設定
let g:tagbar_type_javascript = {
\		'ctagtype': 'JavaScript',
\		'kinds': [
\			'c:classes', 'm:methods', 'f:functions'
\		]
\	}

" JSON type
autocmd BufRead,BufNewFile *.json set filetype=json 

