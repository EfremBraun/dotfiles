filetype on                     " enables filetype detection
filetype plugin on              " enables filetype specific plugins
filetype plugin indent on       " loads vim's ftplugin files automatically when a Python buffer is opened
syntax on                       " syntax highlighting
colorscheme default

" settings needed for both vim and neovim
set nowrap                      " stop lines from wrapping
set ignorecase                  " ignore case when searching
set smartcase                   " if search has a capital letter, don't ignore case when searching

" settings needed for neovim
if has('nvim')
    set clipboard+=unnamedplus  " use system clipboard
    set background=light        " set background to allow me to work with a dark terminal profile
    set mouse=                  " required for copy/paste
    set noautoread              " don't automatically reload file if contents change
endif
" defaults for neovim, so only need to set them for vim
if !has('nvim')
    set ruler                   " show the cursor position all the time
    set showcmd                 " do incremental searching
    set incsearch               " show search matches as you type
    set hlsearch                " highlight search matches
endif

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

" Copilot mappings
"imap <C--> <Plug>(copilot-dismiss)
"imap <C-=> <Plug>(copilot-suggest)
imap <C-\> <Plug>(copilot-next)
imap <C-]> <Plug>(copilot-previous)
imap <C-Right> <Plug>(copilot-accept-word)
imap <C-Down> <Plug>(copilot-accept-line)
