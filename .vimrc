filetype on                     " enables filetype detection
filetype plugin on              " enables filetype specific plugins
filetype plugin indent on       " loads vim's ftplugin files automatically when a Python buffer is opened
syntax on                       " syntax highlighting
colorscheme default

set ruler                       " show the cursor position all the time
set nowrap                      " stop lines from wrapping

set showcmd                     " do incremental searching
set ignorecase                  " ignore case when searching
set smartcase                   " if search has a capital letter, don't ignore case when searching
set incsearch                   " show search matches as you type
set hlsearch                    " highlight search matches

set expandtab                   " use spaces instead of tab characters
set shiftwidth=4                " number of spaces inserted for indentation

" trim whitespace (taken from https://github.com/addschile/dotfiles/blob/master/.config/nvim/functions.vim)
fun! TrimWhitespace()
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
endfun
augroup RMWHITESPACE
    autocmd!
    autocmd BufWritePre * :call TrimWhitespace()
augroup END
