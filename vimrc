if filereadable('$VIMRUNTIME/defaults.vim')
	source $VIMRUNTIME/defaults.vim
endif

call plug#begin('~/.vim/plugged')
Plug 'scrooloose/syntastic'
Plug 'mattn/emmet-vim'
Plug 'Shougo/unite.vim'
Plug 'tpope/vim-fugitive'
Plug 'othree/html5-syntax.vim'
Plug 'majutsushi/tagbar'
Plug 'tpope/vim-rails'
Plug 'dag/vim2hs'
Plug 'nono/jquery.vim'
Plug 'vim-scripts/nginx.vim'
Plug 'kien/ctrlp.vim'
Plug 'leafgarland/typescript-vim'
Plug 'thinca/vim-quickrun'
Plug 'derekwyatt/vim-scala'
Plug 'rking/ag.vim'
Plug 'elzr/vim-json'
Plug 'vim-scripts/sudo.vim'
Plug 'moll/vim-node'
Plug 'osyo-manga/vim-anzu'
Plug 'itchyny/lightline.vim'
Plug 'vim-scripts/closetag.vim'
Plug 'digitaltoad/vim-jade'
Plug 'kchmck/vim-coffee-script'
Plug 'Shougo/vimfiler.vim'
Plug 'heavenshell/vim-jsdoc'
Plug 'rhysd/vim-crystal'
Plug 'elixir-lang/vim-elixir'
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'editorconfig/editorconfig-vim'
Plug 'tomtom/tcomment_vim'
Plug 'rust-lang/rust.vim'
Plug 'fatih/vim-go'

if has('lua')
	Plug 'Shougo/neocomplete'
	Plug 'Shougo/neosnippet'
	Plug 'Shougo/neosnippet-snippets'
endif

call plug#end()

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


" スワップファイル、バックアップを作らない
set nobackup
set noswapfile

" ステータス行
set laststatus=2
"set statusline=%f%m%r%h%w\ %{fugitive#statusline()}\ (%Y)%=\ %l/%L

if v:version >= 800
	" 8進数インクリメントの設定を解除
	set nrformats=bin,hex

	" 折り返し表示オプション
	set linebreak
	set showbreak=>
	set breakindent
	set breakindentopt=shift:6,sbr

	" 絵文字を全角幅で表示
	set emoji
else
	" 8進数インクリメントの設定を解除
	set nrformats=hex

	" 折り返ししない
	set nowrap
endif

" 検索
set hlsearch
set ignorecase
set smartcase

" コマンド補完
set wildmenu

" CJK記号の幅調整（iTermでは Profile > Text > Double-Width Characters > Treat ambiguous-width characters as double widthのチェックも必要）
set ambiwidth=double

" 折りたたみ
set foldmethod=indent
set foldlevel=0
set foldnestmax=1

" カーソルに下線（動作が重くなるので解除）
" set cursorline

" モードライン
set modeline
set modelines=5

" deleteキー操作
set backspace=start,eol,indent

" yankをclipboardへ
set clipboard=unnamed,autoselect

" diffopt追加、デフォルト縦分割にする
set diffopt+=vertical

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

" 選択範囲の小文字化/大文字化を無効化
vnoremap u <Nop>
vnoremap U <Nop>

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

augroup vimrc
	autocmd!
	" auto trim
	autocmd BufWritePre * :%s/\s\+$//ge
augroup END

"" --- Tagbar
nnoremap t :TagbarToggle<CR>
let g:tagbar_type_javascript = {
\		'ctagtype': 'JavaScript',
\		'kinds': [
\			'c:classes',
\			'm:methods',
\			'f:functions',
\			't:testcase',
\			'd:describe'
\		]
\	}

let g:tagbar_type_go = {
\	'ctagstype' : 'go',
\	'kinds'     : [
\ 		'p:package',
\ 		'i:imports:1',
\ 		'c:constants',
\ 		'v:variables',
\		't:types',
\ 		'n:interfaces',
\ 		'w:fields',
\ 		'e:embedded',
\ 		'm:methods',
\ 		'r:constructor',
\ 		'f:functions'
\ 	],
\ 	'sro' : '.',
\ 	'kind2scope' : {
\ 		't' : 'ctype',
\   	'n' : 'ntype'
\   },
\ 	'scope2kind' : {
\ 		'ctype' : 't',
\ 		'ntype' : 'n'
\ 	},
\ 		'ctagsbin'  : 'gotags',
\		'ctagsargs' : '-sort -silent'
\ }


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

	"let g:neosnippet#enable_snipmate_compatibility = 1
	let g:neosnippet#snippets_directory='~/.vim-snippets'
endif

if has('conceal')
	set conceallevel=2 concealcursor=i
endif

if filereadable(expand('~/.vimrc_local'))
	source ~/.vimrc_local
endif
