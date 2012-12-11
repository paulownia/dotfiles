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

" ライン番号
set number

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

" 検索結果をハイライト
set hlsearch

" コマンド補完
set wildmenu

" CJK記号の幅調整
set ambiwidth=double

" 文法で折りたたみ
set foldmethod=syntax

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
let g:syntastic_auto_loc_list = 1
let g:syntastic_javascript_checker = 'jshint'
