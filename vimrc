" vundle
set nocompatible
filetype off
set rtp+=~/.vim/bundle/vundle/
call vundle#begin()

Plugin 'gmarik/vundle'
Plugin 'scrooloose/syntastic'
Plugin 'mattn/emmet-vim'
Plugin 'unite.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'othree/html5-syntax.vim'
Plugin 'majutsushi/tagbar'
Plugin 'tpope/vim-rails'
Plugin 'dag/vim2hs'
Plugin 'jQuery'
Plugin 'nginx.vim'
Plugin 'kien/ctrlp.vim'
Plugin 'leafgarland/typescript-vim'
Plugin 'thinca/vim-quickrun'
Plugin 'derekwyatt/vim-scala'
Plugin 'rking/ag.vim'
Plugin 'elzr/vim-json'
Plugin 'sudo.vim'
Plugin 'moll/vim-node'
Plugin 'osyo-manga/vim-anzu'
Plugin 'itchyny/lightline.vim'
Plugin 'closetag.vim'
Plugin 'digitaltoad/vim-jade'
Plugin 'kchmck/vim-coffee-script'

if has('lua') 
	Plugin 'Shougo/neocomplete'
	Plugin 'Shougo/neosnippet'
	Plugin 'Shougo/neosnippet-snippets'
endif

call vundle#end()

" golang vim
if executable('/usr/local/opt/go/libexec/bin/go')
	set rtp+=/usr/local/opt/go/libexec/misc/vim
endif
"if executable('go')
"	 exe 'set rtp+=' . system('echo -n $(go env GOROOT)/misc/vim')
"endif

filetype plugin indent on

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

" CJK記号の幅調整（iTermでは Profile > Text > Double-Width Characters > Treat ambiguous-width characters as double widthのチェックも必要）
set ambiwidth=double

" 文法で折りたたみ
set foldmethod=syntax

" カーソルに下線
set cursorline

" モードライン
set modeline
set modelines=5

" deleteキー操作
set backspace=start,eol,indent

" yankをclipboardへ
set clipboard+=unnamed

" シンタックスハイライト
syntax on

" ファイルタイプ別プラグインを有効に
filetype on
filetype indent on
filetype plugin on

" インサートモードからノーマルモードへの変換をCtrl-Spaceで
"inoremap <Nul> <ESC>

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


" vimdiff color
hi! DiffAdd      ctermbg=19
hi! DiffDelete   ctermbg=52
hi! DiffChange   ctermbg=22
hi! DiffText     ctermbg=57

" completion menu color
hi! Pmenu ctermbg=0 ctermfg=15
hi! PmenuSel ctermbg=21 ctermfg=15
hi! PmenuSbar ctermbg=8
hi! PmenuThumb ctermfg=4

" search color
hi! Search ctermbg=58 ctermfg=15

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
let g:syntastic_javascript_checkers = ['jshint', 'jscs']
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


"" --- neosnippet
if has('lua') 
	imap <Nul> <Plug>(neosnippet_expand_or_jump)
	smap <Nul> <Plug>(neosnippet_expand_or_jump)
	xmap <Nul> <Plug>(neosnippet_expand_target)

	imap <expr><TAB> neosnippet#expandable_or_jumpable() ?
				\ "\<Plug>(neosnippet_expand_or_jump)"
				\: pumvisible() ? "\<C-n>" : "\<TAB>"
	smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
				\ "\<Plug>(neosnippet_expand_or_jump)"
				\: "\<TAB>"
endif

if has('conceal')
	set conceallevel=2 concealcursor=i
endif

