setlocal lisp autoindent showmatch cpoptions-=mp

" Possible folding method
setlocal foldmethod=marker foldmarker=(,) foldminlines=1

" This allows gf and :find to work
setlocal suffixesadd=.lisp,cl path=~/**

" Allows [d [i [D [I work accross files
setlocal include=(:file\
