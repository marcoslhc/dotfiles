setlocal js autoindent showmatch cpoptions-=mp

" Possible folding method
" setlocal foldmethod=indent foldminlines=1 foldlevelstart=1 foldnestmax=2

" This allows gf and :find to work
setlocal suffixesadd=.js path=~/**

" Allows [d [i [D [I work accross files
setlocal include=

" Set completion
setlocal omnifunc=javascriptcomplete#CompleteJS

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_loc_list_height = 5
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 1
let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_javascript_eslint_exe = '$(npm bin)/eslint'
" let g:syntastic_error_symbol = '❌'
" let g:syntastic_style_error_symbol = '⁉️'
" let g:syntastic_warning_symbol = '⚠️'
" let g:syntastic_style_warning_symbol = '💩'
" highlight link SyntasticErrorSign SignColumn
" highlight link SyntasticWarningSign SignColumn
" highlight link SyntasticStyleErrorSign SignColumn
" highlight link SyntasticStyleWarningSign SignColumn


function! FindConfig(prefix, what, where)
    let cfg = findfile(a:what, escape(a:where, ' ') . ';')
    return cfg !=# '' ? ' ' . a:prefix . ' ' . shellescape(cfg) : ''
endfunction

autocmd FileType javascript let b:syntastic_javascript_jscs_args =
            \ get(g:, 'syntastic_javascript_jscs_args', '') .
            \ FindConfig('-c', '.jscsrc', expand('<afile>:p:h', 1))

autocmd FileType javascript let b:syntastic_javascript_eslint_args =
            \ get(g:, 'syntastic_javascript_eslint_args', '') .
            \ FindConfig('-c', '.eslintrc', expand('<afile>:p:h', 1))