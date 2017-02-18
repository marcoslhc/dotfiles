if $TERM =~# '\v^(screen|xterm)(-.*)'
  set termguicolors

  " set Vim-specific sequences for RGB colors
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  let &t_Co=256
endif

" Make Vim more useful
set nocompatible
"required for vundle
filetype off

set rtp+=~/.vim/bundle/Vundle.vim

call vundle#begin()
" Plugin management
Plugin 'gmarik/Vundle.vim'                        " Plugin Manager

" Terminal access
Plugin 'rosenfeld/conque-term'                    " :ConqueTerm

" Git
Plugin 'tpope/vim-fugitive'                       " :Git
Plugin 'tpope/vim-git'
Plugin 'jreybert/vimagit'                         " :Magit

" Status Line
Plugin 'vim-airline/vim-airline'
Plugin 'edkolev/tmuxline.vim'

" Snippets
Plugin 'mattn/emmet-vim', {'name': 'zenCoding'}   " <Ctrl-y> ,
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'

" Syntaxes
Plugin 'pangloss/vim-javascript'
Plugin 'lambdatoast/elm.vim'

" Code Editing
Plugin 'terryma/vim-multiple-cursors'             " <Ctrl-n>
Plugin 'editorconfig/editorconfig-vim'

" Themes
Plugin 'fneu/breezy'
Plugin 'NLKNguyen/papercolor-theme'

" Tree File Explorer
Plugin 'scrooloose/nerdtree'
Plugin 'jistr/vim-nerdtree-tabs'
Plugin 'Xuyuanp/nerdtree-git-plugin'

" File Search
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'mileszs/ack.vim'

" Clojure
Plugin 'guns/vim-clojure-static'
Plugin 'tpope/vim-salve'                          " :help salve
Plugin 'tpope/vim-projectionist'
Plugin 'tpope/vim-dispatch'
Plugin 'tpope/vim-fireplace'                      " :fireplace
call vundle#end()

set rtp+=~/Documents/Projects/repos/powerline/powerline/bindings/vim
set guifont=Inconsolata\ for\ Powerline\ Medium:h12
set gfn=Inconsolata\ for\ Powerline\ Medium:h14

filetype plugin indent on " required!
"
" Brief help
" :BundleList          - list configured bundles
" :BundleInstall(!)    - install (update) bundles
" :BundleSearch(!) foo - search (or refresh cache first) for foo
" :BundleClean(!)      - confirm (or auto-approve) removal of unused bundles
"
" see :h vundle for more details or wiki for FAQ
" NOTE: comments after Bundle commands are not allowed.

" Use the OS clipboard by default (on versions compiled with `+clipboard`)

set background=dark
colorscheme newton

if has("clipboard") && $TMUX == ''
  set clipboard=unnamed " copy to the system clipboard

  if has("unnamedplus") " X11 support
    set clipboard+=unnamedplus
  endif
endif

" Enhance command-line completion
set wildmode=list:longest,full
set wildmenu "turn on wild menu
set wildignore=*.o,*.obj,*~ "stuff to ignore when tab completing
set wildignore+=*DS_Store*
set wildignore+=vendor/rails/**
set wildignore+=vendor/cache/**
set wildignore+=*.gem
set wildignore+=log/**
set wildignore+=tmp/**
set wildignore+=*.png,*.jpg,*.gif
set wildignore+=*.so,*.swp,*.zip,*/.Trash/**,*.pdf,*.dmg,*/Library/**,*/.rbenv/**
set wildignore+=*/.nx/**,*.app

" Cursor settings. This makes terminal vim sooo much nicer!
" Tmux will only forward escape sequences to the terminal if surrounded
" by a DCS sequence
if exists('$TMUX')
  let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
  let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
else
  let &t_SI = "\<Esc>]50;CursorShape=1\x7"
  let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif

" Allow cursor keys in insert mode
set esckeys
" Allow backspace in insert mode
set backspace=indent,eol,start
" Optimize for fast terminal connections
set ttyfast
" Add the g flag to search/replace by default
set gdefault
" Use UTF-8 without BOM
set encoding=utf-8 nobomb
" Change mapleader
let mapleader=","
" Don’t add empty newlines at the end of files
set binary
set noeol
" Centralize backups, swapfiles and undo history
set backupdir=~/.vim/backups
set directory=~/.vim/swaps
if exists("&undodir")
  set undodir=~/.vim/undo
endif

" Don’t create backups when editing files in certain directories
set backupskip=/tmp/*,/private/tmp/*

" Respect modeline in files
set modeline
set modelines=4
" Enable per-directory .vimrc files and disable unsafe commands in them
set exrc
set secure
" Set indent in softwrap
set linebreak
set wrap
set bri
set briopt=shift:4,sbr
" Enable line numbers
set number
" Enable syntax highlighting
syntax on
" Highlight current line
set cursorline

" set tab column width when reindentin and autoindenting
set shiftwidth=4
" set tab column width when hitting tab in insert mode
set softtabstop=4
" Make tabs as wide as two spaces
set tabstop=4
" Indent with spaces
set expandtab
" Show “invisible” characters
set lcs=tab:▸\ ,trail:·,eol:¬,nbsp:_,space:·
set list
" Highlight searches
set hlsearch
" Ignore case of searches
set ignorecase
" Highlight dynamically as pattern is typed
set incsearch
" Always show status line
set laststatus=2
" Enable mouse in all modes
set mouse=a
" Disable error bells
set noerrorbells
" Don’t reset cursor to start of line when moving around.
set nostartofline
" Show the cursor position
set ruler
" Don’t show the intro message when starting Vim
set shortmess=atI
" Show the current mode
set showmode
" Show the filename in the window titlebar
set title
" Show the (partial) command as it’s being typed
set showcmd
" Use relative line numbers
if exists("&relativenumber")
    set relativenumber
    au BufReadPost * set relativenumber
endif
" Start scrolling three lines before the horizontal window border
set scrolloff=3

" Strip trailing whitespace (,ss)
function! StripWhitespace()
  let save_cursor = getpos(".")
  let old_query = getreg('/')
  :%s/\s\+$//e
  call setpos('.', save_cursor)
  call setreg('/', old_query)
endfunction
noremap <leader>ss :call StripWhitespace()<CR>
" Save a file as root (,W)
noremap <leader>W :w !sudo tee % > /dev/null<CR>

" Automatic commands
if has("autocmd")
  " Enable file type detection
  filetype on
  "Treat js files as js
  autocmd BufNewFile,BufRead *.js setfiletype javascript syntax=javascript
  " Treat .json files as .js
  autocmd BufNewFile,BufRead *.json setfiletype json syntax=javascript
  " Treat .md files as Markdown
  autocmd BufNewFile,BufRead *.md setlocal filetype=markdown
endif

set splitright
set splitbelow


let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
let g:airline_powerline_fonts = 1
let g:airline_theme='breezy'

autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif

set omnifunc=syntaxcomplete#Complete

if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif

" F10 - Shows the Hightlight Group under the cursor
map <F10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '>
      \ trans<' . synIDattr(synID(line("."),col("."),0),"name") . ">
      \ lo<" . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>