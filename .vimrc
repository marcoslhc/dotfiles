if $TERM =~# '\v^(screen|xterm)(-.*)'
set termguicolors

  " set Vim-specific sequences for RGB colors
  let &t_8f = "[38;2;%lu;%lu;%lum"
  let &t_8b = "[48;2;%lu;%lu;%lum"
  let &t_Co=256
endif

" Make Vim more useful
set nocompatible
"required for vundle
filetype off

set rtp+=~/.vim/bundle/Vundle.vim

set rtp+=$GOPATH/src/github.com/golang/lint/misc/vim

set path+=$PATH:expand('~/.cabal/bin')
call plug#begin('~/.vim/plugged')
" Plugin management
" Plug 'gmarik/Vundle.vim'                        " Plugin Manager
Plug 'Shougo/vimproc.vim', {'do' : 'make'}

" Terminal access
Plug 'rosenfeld/conque-term'                    " :ConqueTerm

" Git
Plug 'tpope/vim-fugitive'                       " :Git
Plug 'tpope/vim-git'
Plug 'jreybert/vimagit'                         " :Magit

" Status Style & Line
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'arcticicestudio/nord-vim'
" Plug 'edkolev/tmuxline.vim'

" Snippets
Plug 'mattn/emmet-vim', { 'as': 'zencoding' }  " <Ctrl-y> ,
" Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

" Syntaxes
Plug 'pangloss/vim-javascript', { 'for': 'javascript' }
Plug 'mxw/vim-jsx', { 'for': 'javascript' }
Plug 'lambdatoast/elm.vim'
Plug 'flowtype/vim-flow', { 'for': 'javascript' }
" Plug 'leafgarland/typescript-vim', { 'for': 'typescript' }
Plug 'guns/vim-clojure-highlight', { 'for': 'clojure' }
Plug 'eagletmt/ghcmod-vim'

" Code Editing
Plug 'terryma/vim-multiple-cursors'             " <Ctrl-n>
Plug 'editorconfig/editorconfig-vim'
Plug 'vim-syntastic/syntastic'
Plug 'maksimr/vim-jsbeautify', { 'for': 'javascript' }
Plug 'Quramy/tsuquyomi'
Plug 'Quramy/vim-js-pretty-template', { 'for': 'javascript' }
Plug 'vim-scripts/paredit.vim', { 'for': 'javascript' }
Plug 'tpope/vim-surround'
Plug 'kien/rainbow_parentheses.vim'
Plug 'w0rp/ale'

" Themes
Plug 'fneu/breezy'
Plug 'NLKNguyen/papercolor-theme'
Plug 'ayu-theme/ayu-vim'
Plug 'nathanaelkane/vim-indent-guides'

" Tree File Explorer
Plug 'scrooloose/nerdtree'
Plug 'jistr/vim-nerdtree-tabs'
Plug 'Xuyuanp/nerdtree-git-plugin'

" File Search
Plug 'ctrlpvim/ctrlp.vim'
Plug 'mileszs/ack.vim'

" Clojure
Plug 'guns/vim-clojure-static', { 'for': 'clojure' }
Plug 'tpope/vim-salve', { 'for': 'clojure' }       " :help salve
Plug 'tpope/vim-projectionist' , { 'for': 'clojure' }
Plug 'tpope/vim-dispatch', { 'for': 'clojure' }
Plug 'tpope/vim-fireplace', { 'for': 'clojure' }   " :fireplace

" Git
Plug 'jisaacks/gitgutter'

" Terminal Integration
Plug 'wincent/terminus'
call plug#end()

let g:airline#extensions#ale#enabled = 1

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

" set background=dark
"colorscheme nord
let ayucolor="mirage"
colorscheme ayu

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
" set esckeys
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
set lcs=tab:▸\ ,trail:·,eol:¬,nbsp:_
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
  " Treat .json files as .js
  autocmd BufNewFile,BufRead *.json setfiletype json syntax=javascript
  " Treat .md files as Markdown
  autocmd BufNewFile,BufRead *.md setlocal filetype=markdown
endif

set splitright
set splitbelow


" let g:UltiSnipsExpandTrigger="<tab>"
" let g:UltiSnipsJumpForwardTrigger="<c-b>"
" let g:UltiSnipsJumpBackwardTrigger="<c-z>"
let g:airline_powerline_fonts = 1
let g:airline_theme='ayu_mirage'
" let g:airline_theme='breezy'

autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif

set omnifunc=syntaxcomplete#Complete

if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif

" let g:syntastic_javascript_checkers = ['eslint']

" let g:syntastic_debug = 3

autocmd FileType javascript noremap <buffer>  <c-f> :call JsBeautify()<cr>
"for json
autocmd FileType json noremap <buffer> <c-f> :call JsonBeautify()<cr>
" for jsx
autocmd FileType jsx noremap <buffer> <c-f> :call JsxBeautify()<cr>
" " for html
autocmd FileType html noremap <buffer> <c-f> :call HtmlBeautify()<cr>
" for css or scss
autocmd FileType css noremap <buffer> <c-f> :call CSSBeautify()<cr>

autocmd VimEnter * RainbowParenthesesToggle
autocmd Syntax clojure RainbowParenthesesLoadRound
autocmd Syntax clojure RainbowParenthesesLoadSquare
autocmd Syntax clojure RainbowParenthesesLoadBraces

autocmd BufRead *.clj try | silent! Require | catch /^Fireplace/ | endtry

nnoremap ; :

nnoremap <leader>ev :vsplit $MYVIMRC

nnoremap <leader>sv :source $MYVIMRC

map <F10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
            \ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
            \ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

" Activate JSX in js files
let g:jsx_ext_required = 0

" CtrlP options
let g:ctrlp_custom_ignore = {
  \'dir': '\v\./node_modules'
  \}

let g:ctrlp_match_window = 'top,order:ttb,min:1,max:30,results:50'

let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files . -co --exclude-standard', 'find %s -type f']

" Nord Config
let g:nord_italic = 1
let g:nord_italic_comments = 1
let g:nord_comment_brightness = 12
let g:nord_uniform_diff_background = 1

" ## added by OPAM user-setup for vim / base ## 93ee63e278bdfc07d1139a748ed3fff2 ## you can edit, but keep this line
let s:opam_share_dir = system("opam config var share")
let s:opam_share_dir = substitute(s:opam_share_dir, '[\r\n]*$', '', '')

let s:opam_configuration = {}

function! OpamConfOcpIndent()
  execute "set rtp^=" . s:opam_share_dir . "/ocp-indent/vim"
endfunction
let s:opam_configuration['ocp-indent'] = function('OpamConfOcpIndent')

function! OpamConfOcpIndex()
  execute "set rtp+=" . s:opam_share_dir . "/ocp-index/vim"
endfunction
let s:opam_configuration['ocp-index'] = function('OpamConfOcpIndex')

function! OpamConfMerlin()
  let l:dir = s:opam_share_dir . "/merlin/vim"
  execute "set rtp+=" . l:dir
endfunction
let s:opam_configuration['merlin'] = function('OpamConfMerlin')

let s:opam_packages = ["ocp-indent", "ocp-index", "merlin"]
let s:opam_check_cmdline = ["opam list --installed --short --safe --color=never"] + s:opam_packages
let s:opam_available_tools = split(system(join(s:opam_check_cmdline)))
for tool in s:opam_packages
  " Respect package order (merlin should be after ocp-index)
  if count(s:opam_available_tools, tool) > 0
    call s:opam_configuration[tool]()
  endif
endfor
" ## end of OPAM user-setup addition for vim / base ## keep this line
nnoremap <Leader>ht :GhcModType<cr>
nnoremap <Leader>htc :GhcModTypeClear<cr>
autocmd FileType haskell nnoremap <buffer> <leader>? :call ale#cursor#ShowCursorDetail()<cr>
