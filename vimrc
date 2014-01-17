" vundle
set nocompatible
" filetype off
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'gmarik/vundle'
Bundle 'scrooloose/syntastic'
Bundle 'mattn/emmet-vim'
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
Bundle 'derekwyatt/vim-scala'
Bundle 'rking/ag.vim'
Bundle 'elzr/vim-json'
Bundle 'sudo.vim'
Bundle 'moll/vim-node'
Bundle 'osyo-manga/vim-anzu'
Bundle 'itchyny/lightline.vim'
Bundle 'closetag.vim'

" ライン番号
" set number

" スクロール
set scrolloff=4

" タブ幅
set noexpandtab
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
"set statusline=%f%m%r%h%w\ %{fugitive#statusline()}\ (%Y)%=\ %l/%L

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

" モードライン
set modeline
set modelines=5

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

" vertical diffsplit
nnoremap vd :vertical diffsplit 

" filetype
autocmd BufRead,BufNewFile *.md set filetype=markdown



"" --- Tagbar
nnoremap t :TagbarToggle<CR>
let g:tagbar_type_javascript = {
\		'ctagtype': 'JavaScript',
\		'kinds': [
\			'c:classes', 'm:methods', 'f:functions'
\		]
\	}


"" --- Unite
nnoremap UM :Unite file_mru<CR>
nnoremap UB :Unite buffer<CR>
nnoremap UF :Unite file<CR>
nnoremap UR :Unite file_rec<CR>


"" --- vim-anzu
" mapping
nmap n <Plug>(anzu-n-with-echo)
nmap N <Plug>(anzu-N-with-echo)
nmap * <Plug>(anzu-star-with-echo)
nmap # <Plug>(anzu-sharp-with-echo)
" clear status
nmap <Esc><Esc> <Plug>(anzu-clear-search-status)


"" --- Syntastic
" JavaScript / jshintを使う
let g:syntastic_javascript_checkers = ['jshint']
let g:syntastic_auto_loc_list = 1

" C++ / include pathを指定
let g:syntastic_cpp_include_dirs = [ 'include/']
let g:syntastic_cpp_check_header = 1
let g:syntastic_cpp_remove_include_errors = 1

" Java / javac設定
let g:syntastic_java_javac_options = '-Xlint -J-Dfile.encoding=UTF-8'
" let g:syntastic_java_javac_delete_output = 0
" let g:syntastic_java_javac_temp_dir = '/tmp'

" HTML / Angularの属性をチェックしない
let g:syntastic_html_tidy_ignore_errors=[' proprietary attribute "ng-']


"" --- QuickRun
" 結果を上下分割で表示
let g:quickrun_config = {}
let g:quickrun_config._ = { 'split': '' }


"" --- lightline
let g:lightline = {
\		'colorscheme': 'wombat',
\		'active': {
\			'left': [
\				[ 'mode', 'paste' ],
\				[ 'filename', 'fugitive', 'readonly', 'modified']
\			]
\		},
\		'component': {
\			'fugitive': '%{fugitive#statusline()}'
\		},
\		'component_visible_condition': {
\			'fugitive': '(exists("*fugitive#head") && ""!=fugitive#head())'
\		}
\	}

