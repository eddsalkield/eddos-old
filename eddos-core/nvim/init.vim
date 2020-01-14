call plug#begin(stdpath('data') . '/plugged')

Plug 'tpope/vim-sensible'
Plug 'jeffkreeftmeijer/vim-numbertoggle'

call plug#end()

set number relativenumber

"Filetype indentations
filetype indent plugin on
autocmd FileType python setlocal shiftwidth=8 tabstop=8
autocmd FileType rust setlocal shiftwidth=4 tabstop=4 expandtab
