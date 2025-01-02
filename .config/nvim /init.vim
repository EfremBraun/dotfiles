" per https://vi.stackexchange.com/questions/12794/how-to-share-config-between-vim-and-neovim
set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc

" per https://github.com/CopilotC-Nvim/CopilotChat.nvim and https://github.com/nanotee/nvim-lua-guide
lua << EOF                    
require("CopilotChat").setup {             
  -- See Configuration section for options
} 
EOF
