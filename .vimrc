"************************************************
" Key Mapping
"************************************************
let mapleader = ","
" ,のデフォルトの機能は、\で使えるように退避
noremap \ ,

" 選択範囲をクリップボードにコピー
vnoremap <C-c> "+y
if has('!gui_running')
  vnoremap <RightMouse> "+y
endif
" クリップボードからペースト
noremap <MiddleMouse> "+p
inoremap <C-v> <C-o>:set paste<CR><C-r>+<C-o>:set nopaste<CR>

" 矢印キーでは表示行単位で行移動する
nnoremap <UP> gk
nnoremap <DOWN> gj
vnoremap <UP> gk
vnoremap <DOWN> gj

" 検索ハイライトをESC2度押しで消す
nnoremap <ESC><ESC> :nohlsearch<CR>

" インデントを連続で変更
vnoremap < <gv
vnoremap > >gv

" タブ移動
nnoremap <C-LEFT> gT
nnoremap <C-RIGHT> gt

" " ウィンドウ移動
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" PasteMode
set pastetoggle=<F9>
" PasteModeを自動で抜ける
augroup pasteMode
  autocmd InsertLeave * set nopaste
augroup END

" tabnew
nnoremap <silent> <Leader>t :<C-u>tabnew<CR>

" shell
if has('nvim')
  nnoremap <silent> <Leader>s :<C-u>terminal<CR>i
else
  nnoremap <silent> <Leader>s :<C-u>terminal ++rows=8<CR>
endif
tnoremap <silent> <ESC> <C-\><C-n>

" ctags
nnoremap Tj g<C-]>
nnoremap Tb <C-t>

" omni
inoremap <C-f> <C-x><C-o>

"************************************************
" dain
"************************************************
filetype off                   " Required!

" dein dir
let s:dein_dir = expand('~/.vim/dein')
" dein.vim
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

" clone dein
if &runtimepath !~# '/dein.vim'
  if !isdirectory(s:dein_repo_dir)
    execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
  endif
  execute 'set runtimepath^=' . s:dein_repo_dir
endif

if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)
  call dein#add('Shougo/dein.vim')
  "" -------------------------------
  call dein#load_toml('~/.vim/toml/base.toml')
  call dein#load_toml('~/.vim/toml/code.toml')
  call dein#load_toml('~/.vim/toml/syntax.toml')
  call dein#load_toml('~/.vim/toml/lsp.toml')
  "" -------------------------------
  call dein#end()
endif

if dein#check_install()
  call dein#install()
endif

filetype plugin indent on     " Required!
syntax on

"************************************************
" Basic Settings
"************************************************
set directory=$HOME/.vim/swap
set backup
set backupdir=$HOME/.vim/backup
set undofile
set undodir=$HOME/.vim/undo
if has('nvim')
  set viminfo+=n~/.vim/nviminfo
else
  set viminfo+=n~/.vim/viminfo
endif

" Encoding
set encoding=utf-8
set fileencodings=utf-8,sjis,euc-jp,iso-2022-jp
set fileformats=unix,dos,mac
"set noeol nofixeol
scriptencoding utf-8

" Tab
set expandtab
set tabstop=4
set softtabstop=0
set shiftwidth=4

" Search
set hlsearch
set incsearch
set ignorecase
set smartcase
set imsearch=0
set shortmess-=S
nnoremap / /\v
if has('nvim')
  set inccommand=split
endif

" Tab & Trailing Space
set list
set listchars=tab:^\ ,trail:_,extends:>,precedes:<

" 全角スペースをハイライト
highlight IdeographicSpace term=underline ctermbg=DarkGreen guibg=DarkGreen
augroup highlightIdegraphicSpace
  autocmd!
  autocmd Colorscheme * highlight IdeographicSpace term=underline ctermbg=DarkGreen guibg=DarkGreen
  autocmd VimEnter,WinEnter * match IdeographicSpace /　/
augroup END

" StatusLine
set laststatus=2

" Mouse
set mouse=a

" マッピング待ちとキーコード待ちの時間
set timeout timeoutlen=3000 ttimeoutlen=100

" IME
set iminsert=0
if has('multi_byte_ime') || has('xim')
  " 挿入モードのIME状態を記憶しないようにする
  "inoremap <silent> <ESC> <ESC>:set iminsert=0<CR>
endif

" Color
if has('unix')
  set termguicolors
  colorscheme desert
else
  colorscheme elflord
endif
augroup HighlightColor
  autocmd!
  autocmd VimEnter,ColorScheme * highlight Search ctermbg=3 ctermfg=8
  autocmd VimEnter,ColorScheme * highlight Pmenu ctermbg=5 ctermfg=255 guibg=DarkMagenta
  autocmd VimEnter,ColorScheme * highlight lCursor ctermbg=7 ctermfg=0
augroup END

" Quickfixを自動で閉じる
augroup QfAutoCommands
  autocmd!
  " Auto-close quickfix window
  autocmd WinEnter * if (winnr('$') == 1) && (getbufvar(winbufnr(0), '&buftype')) == 'quickfix' | quit | endif
augroup END

" Windowsでpythonインターフェイスを有効にする
if has('win32')
  if has('nvim')
    let g:python3_host_prog = $PYTHONHOME . '\python.exe'
  else
    set pythonthreedll=$PYTHONDLL
  endif
endif

" Others
set number
set scrolloff=10
set whichwrap=b,s,<,>,[,],~
set ambiwidth=double
set backspace=2 "indent,eol,start
set clipboard=

"************************************************
" FileType
"************************************************
augroup FiletypeGroup
  autocmd!
  autocmd FileType vim setlocal sw=2 sts=2 ts=2 et
  autocmd BufRead,BufNewFile *.js setlocal shiftwidth=2 tabstop=2
  autocmd BufRead,BufNewFile *.jsx setlocal shiftwidth=2 tabstop=2 filetype=javascript.jsx
  autocmd BufRead,BufNewFile *.ts setlocal shiftwidth=2 tabstop=2
  autocmd BufRead,BufNewFile *.tsx setlocal shiftwidth=2 tabstop=2 filetype=typescript.tsx
  autocmd BufRead,BufNewFile *.html setlocal shiftwidth=2 tabstop=2 filetype=html
  autocmd BufRead,BufNewFile *.ejs setlocal shiftwidth=2 tabstop=2 filetype=ejs.html
  autocmd BufRead,BufNewFile *.css setlocal shiftwidth=2 tabstop=2
  autocmd BufRead,BufNewFile *.scss setlocal shiftwidth=2 tabstop=2
  autocmd BufRead,BufNewFile *.ctp setlocal filetype=php
  autocmd BufRead,BufNewFile *.go setlocal filetype=go noexpandtab
augroup END

"************************************************
" Command
"************************************************
" Encoding
:command! Sutf set fenc=utf-8
:command! Scp set fenc=cp932
:command! Seuc set fenc=euc-jp
:command! Suni set ff=unix
:command! Sdos set ff=dos

"************************************************
" Coding
"************************************************
" PHP
" $VIMRUNTIME/syntax/php.vim
let g:php_baselib       = 1
let g:php_htmlInStrings = 1
let g:php_noShortTags   = 1
let g:php_sql_query     = 1
"let g:sql_type_default = 'mysql'

"************************************************
" Local Setting
"************************************************
set runtimepath+=$HOME/.vim/
runtime! localrc/vimrc.vim
