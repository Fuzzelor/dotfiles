" ==============================================================================
" Intitialize 
" ==============================================================================

set nocompatible              " be iMproved, required
filetype off                  " required

" Create the autocmd group used by all my autocmds (cleared when sourcing vimrc)
augroup vimrc
    autocmd!
augroup END

so $HOME/.config/nvim/plugins.vim

syntax on
filetype plugin indent on    " required

" ==============================================================================
" Plugin settings
" ==============================================================================
so $HOME/.config/nvim/plugsettings/nerdcommenter.vim
so $HOME/.config/nvim/plugsettings/rainbow.vim
so $HOME/.config/nvim/plugsettings/nerdtree.vim
so $HOME/.config/nvim/plugsettings/gitgutter.vim
so $HOME/.config/nvim/plugsettings/airline.vim
so $HOME/.config/nvim/plugsettings/fugitive.vim
so $HOME/.config/nvim/plugsettings/easyalign.vim
so $HOME/.config/nvim/plugsettings/fzf.vim
so $HOME/.config/nvim/plugsettings/vim-which-key.vim
so $HOME/.config/nvim/plugsettings/vimwiki.vim
so $HOME/.config/nvim/plugsettings/vim-sneak.vim
so $HOME/.config/nvim/plugsettings/colorizer.vim


" ==============================================================================
" Bindings 
" ==============================================================================

" Comma
" ----------------------------------------------

" Juggling with buffers
" Comma, how you want to view the buffer, then b
" 'b' for buffer
nnoremap ,b :ls<CR>:buffer<Space>
nnoremap ,sb :ls<CR>:sbuffer<Space>
nnoremap ,vb :ls<CR>:vert sbuffer<Space>
nnoremap ,, :bnext<CR>
nnoremap ,bd :bd<CR>

" Juggling with files
" Same for opening new files, just replace b with f (for recursive, just like
" :find) or e (for non-recursive, just like :edit)
" 'f' for find
" 'e' for edit
nnoremap ,e :edit<Space>
nnoremap ,se :split<Space>
nnoremap ,ve :vsplit<Space>

" Juggling with windows
" Same bindings for split/vsplit/tab as above, just double the letter *or* wait
" for the timeout
nnoremap ,s :split<CR>
nnoremap ,t :tabnew<CR>
nnoremap ,v :vsplit<CR>

" Close stuff
" 'c' for close
nnoremap ,c :close<CR>
" 'tc' for tabclose
nnoremap ,tc :tabclose<CR>

" Folding switches
nnoremap ,fm :set foldmethod=marker<CR>
nnoremap ,fi :set foldmethod=indent<CR>

" Space
" ----------------------------------------------

" Auto-indent the whole file
" 'i' for indent
nnoremap <Space>i mzgg=G`zzz

" Sort the current paragraph alphabetically
" 's' for sort
nnoremap <Space>s mzvip:sort<CR>`z

" Redraw the screen
" 'r' for redraw
nnoremap <Space>r :redraw!<CR>

" Run the linter/compiler
" 'm' for make
nnoremap <Space>m :update<CR>:make<CR>

" Quick 'n' easy find-and-replace
nnoremap <Space><Space> :'{,'}s/\<<C-r>=expand("<cword>")<CR>\>/
nnoremap <Space>%       :%s/\<<C-r>=expand("<cword>")<CR>\>/

" ==============================================================================
" General Settings 
" ==============================================================================
" Editing
" ----------------------------------------------
set backspace=2                       " Backspace over everything
set clipboard^=unnamed                " Use macOS clipboard when available
set dictionary+=/usr/share/dict/words " Larger dictionary
set formatoptions=1cjqr               " Wrap and join comments intelligently
set mouse=nvc                         " Use mouse in all modes except insert
set nojoinspaces                      " Insert only one space after punctuation
set nostartofline                     " Keep cursor on same column
set nrformats+=alpha                  " Allow incrementing single alphabetics
set nrformats-=octal                  " Do not consider octal numbers
set sessionoptions-=options           " Don't keep manually-set options
set spelllang=en_gb                   " Use British English
set tags=./tags;,tags                 " Where to search for tags
set textwidth=80                      " 80 chars/line
set virtualedit=block                 " Better visual block mode

" User interface and interactions
" ----------------------------------------------
set belloff=all           " Disable all bells
set colorcolumn=+1        " Show a marker one char after textwidth
set completeopt+=menuone  " Show completions when there is a match
"set completeopt+=noselect " Required for MUComplete
set completeopt+=preview  " Display extra info about the match
set conceallevel=0        " Never conceal
set display=lastline      " Show as much of partly-displayed lines as possible
set guifont="SauceCodePro Nerd Font Mono Bold":13pt     " Use Menlo 14pt if running in MacVim
set guioptions=           " Hide scrollbars in MacVim
set laststatus=2          " Always display statusline
set lazyredraw            " Don't redraw during macros
set linespace=3           " Add a little bit of extra leading to tight Menlo
set number                " Show line numbers
set numberwidth=5         " Make enough space for triple-digit line numbers
set pumheight=7           " Show 7 completion items before showing a scrollbar
set shortmess=acIT        " Abbreviate error messages
set showcmd               " Tells you if you press a non-alphabetic key
set splitbelow            " Create new splits to the bottom
set splitright            " Create new splits to the right
set tabpagemax=50         " Maximum number of tab pages

" Make redrawing smoother
" ----------------------------------------------
set ttyfast

" Time out mapping after 1000ms
" ----------------------------------------------
set ttimeout
set ttimeoutlen=100
set timeoutlen=500

" Dynamic cursor shape that does not blink
" ----------------------------------------------
if has('nvim')
    set guicursor=n-v-c-ci:block,i-ve:ver25,r-cr:hor20,o:hor50,n:blinkon0
else
    let &t_SI.="\e[5 q"
    let &t_SR.="\e[4 q"
    let &t_EI.="\e[1 q"
endif

" Smart window title
" ----------------------------------------------
function! ProxyIconTitle(prefix,suffix) abort
    " This is the format used by Terminal.app to specify what file is being
    " edited
    let filenameurl = 'file://' . hostname() . expand('%:p')

    " This is how the command used to specify the window title is structured in
    " both Vim and Nvim, so we specify it here
    let args = a:prefix . filenameurl . a:suffix

    if has('nvim')
        " We use Nvim's chansend to send the escape codes because it is more direct
        " than printf
        let cmd = 'call chansend(2, "' . args . '")'
        execute cmd
    else
        " Use printf to call escape sequence because chansend() is unique to Nvim
        let cmd = 'silent !printf "' . args . '"'
        execute cmd
        execute 'redraw!'
        execute 'redraw!'
    endif
endfunction

" Make the gui's window title match with the others
" ----------------------------------------------
if has('gui_running')
    set title
    set titlestring=%t\ —\ gvim
else
    " Only run proxy icon code if we are in Terminal.app (no other terminal
    " emulators have implemented this feature)
    if $TERM_PROGRAM ==# 'Apple_Terminal'
        " Tmux requires different escape codes, so we check if we are in tmux and
        " set which escape codes are called accordingly.
        if $TERM ==# 'tmux-256color-italic'
            " Refresh window title on BufEnter (when switching files) and on
            " FocusGained (when switching tmux panes)
            "
            " This also sets the current window's name to the current filename
            autocmd vimrc BufEnter,FocusGained *
                        \ call ProxyIconTitle('\ePtmux;\e\e]6;','\e\\')
                        \ | call system("tmux rename-window $(echo " . expand("%:t") . ")")
        else
            autocmd vimrc BufEnter,FocusGained *
                        \ call ProxyIconTitle('\e]6;','')
        endif
    else
        " If setting a proxy icon is unavailable ...
        if $TERM ==# 'tmux-256color-italic'

            " Set the current tmux window's name to the file currently being edited in
            " Vim
            autocmd vimrc BufEnter,FocusGained *
                        \ call system("tmux rename-window $(echo " . expand("%:t") . ")")
        else
            " If we are not in tmux or in Terminal.app then set the window title to
            " the current filename and the current program (Vim or Nvim)
            set title
            if has('nvim')
                set titlestring=%t\ —\ nvim
            else
                set titlestring=%t\ —\ vim
            endif
        endif
    endif
endif

" Buffers and files
" ----------------------------------------------

set autoread     " Read a file again if it has been modified outside of Vim
set hidden       " A buffer becomes hidden when abandoned
set path=$PWD/** " Recursively search directories

" Viminfo
" ----------------------------------------------

set viminfo+=! " Save uppercase variables into viminfo (default behavoiur)

" Undo
" ----------------------------------------------

" Only use persistent undo if Vim has it compiled in
if has('persistent_undo')
    set undodir=~/.vim/undo " Save undo history here
    set undofile            " Keep undo history between sessions
    " Automatically create directory for undo if it does not exist
    if !isdirectory(expand('~').'/.vim/undo')
        !mkdir -p $HOME/.vim/undo
    endif
endif

" Backup
" ----------------------------------------------

set backup                  " Make a backup of every file you open in Vim
set backupdir=~/.vim/backup " Save backups here

" Automatically create directory for backups if it does not exist
if !isdirectory(expand('~').'/.vim/backup')
    !mkdir -p $HOME/.vim/backup
endif

" Swapfiles
" ----------------------------------------------

set swapfile                " Create swapfiles
set directory=~/.vim/swap// " Save swap files here

" Automatically create directory for swapfiles if it does not exist
" ----------------------------------------------
if !isdirectory(expand('~').'/.vim/swap')
    !mkdir -p $HOME/.vim/swap
endif

" Searching, substitute, global, etc
" ----------------------------------------------

set nohlsearch   " Highlight search matches
set ignorecase " Ignore
set incsearch  " Jump to search results as you type
set smartcase  " Smarter capitalisation when searching

" Do not jump to the next match automatically when searching for the current
" word
" ----------------------------------------------
nnoremap * *N
nnoremap # #N
nnoremap g* g*N
nnoremap g# g#N

" Live preview of substitute command
" ----------------------------------------------
if has('nvim')
    set inccommand=split
endif

" Use ripgrep if available, fall back to the silver searcher, then fall back to
" the system grep for grepping
" ----------------------------------------------
if executable('rg')
    set grepprg=rg\ --vimgrep\ -i
    set grepformat^=%f:%l:%c:%m
elseif executable('ag')
    set grepprg=ag\ --vimgrep\ -i
    set grepformat^=%f:%l:%c:%m
else
    set grepprg=grep\ -iR
endif

" Smarter grep command
" ----------------------------------------------
command! -nargs=+ -complete=file_in_path -bar Grep
            \ silent! grep! <q-args> | redraw!

" Wrapping and scrolling
" ----------------------------------------------

if exists('+breakindent')
    let &showbreak = '››› ' " Mark which lines have been wrapped with three arrows
    set breakindent         " Display indents before wrapped lines
    set breakindentopt=sbr  " Display  showbreak  before indent
endif
if has('linebreak')
    set linebreak           " Don't break words
endif
set scrolloff=1           " Show one line of context around the cursor
set sidescroll=1          " Scroll horizontally when wrapping is disabled
set sidescrolloff=5       " Show five columns of context around the cursor
set wrap                  " Soft wrap text

" Indentation

set autoindent   " Copy the previous line's indent to the current one
set shiftround   " Always set indentation to a multiple of 2
set smarttab     " Indent and dedent in insert mode using <Tab>

" Command-line

set history=1000     " Save a lot of command-line history
set wildcharm=<C-z>  " Use <C-z> when tab completing (for incsearch tab mapping)
set wildignorecase   " Ignore case when completing files and directories
set wildmenu         " Better command-line completion
set wildmode=longest " Complete the longest common string
set wildmode+=full   " … then each full match

" ==============================================================================
" Statusline 
" ==============================================================================

" The file

set statusline=\     " Add space to start us off
set statusline+=%f\  " Filename relative to PWD

" Flags

set statusline+=%m   " Modified flag
set statusline+=%r   " Readonly flag
set statusline+=%=   " Separator to jump to the other side

" Position

set statusline+=%l   " Current line
set statusline+=\/   " Solidus
set statusline+=%-6L " Total lines in file (plus 6 padding on the right)
set statusline+=%3c  " Current column (padded for less than 4 chars)
set statusline+=\    " Finish off with a space

" ==============================================================================
" Theming 
" ==============================================================================

set relativenumber
set number

set expandtab
set shiftwidth=4
set softtabstop=4
set tabstop=4
set foldenable

syntax on
let g:material_style='palenight'
set background=dark
colorscheme gruvbox
"colorscheme seoul256

" Folding
" ------------------------------------------------------------------------------

if has('folding')
    if has('windows')
        set fillchars=vert:┃    " Heavy vertical Box \u2503
        set fillchars+=fold:·   " Middle Dot \u00b7
    endif
    set foldmethod=indent
    set foldlevelstart=99
    set foldmarker={{{,}}}
    set foldtext=caya#settings#foldtext()
endif
