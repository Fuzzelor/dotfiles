" ==============================================================================
" plug Plugins {{{
" ==============================================================================
" set the runtime path to include plug and initialize
"set rtp+=~/.vim/aut/plug.vim
call plug#begin()
    Plug 'hzchirs/vim-material'
    Plug 'morhetz/gruvbox'

    Plug 'junegunn/vim-easy-align'
    Plug 'oblitum/rainbow'
    Plug 'justinmk/vim-sneak'

    Plug 'junegunn/fzf'
    Plug 'junegunn/fzf.vim'
    Plug 'jremmen/vim-ripgrep'

    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'

    Plug 'scrooloose/nerdtree'
    Plug 'Xuyuanp/nerdtree-git-plugin'

    Plug 'tpope/vim-fugitive'
    Plug 'tpope/vim-surround'
    Plug 'airblade/vim-gitgutter'

    Plug 'sheerun/vim-polyglot'

    Plug 'vimwiki/vimwiki'
    Plug 'liuchengxu/vim-which-key'
    Plug 'norcalli/nvim-colorizer.lua'
    " All of your Plugins must be added before the following line
call plug#end()            " required
