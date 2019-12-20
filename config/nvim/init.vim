" ==============================================================================
" Intitalize {{{
" ==============================================================================

set nocompatible              " be iMproved, required
filetype off                  " required

" Create the autocmd group used by all my autocmds (cleared when sourcing vimrc)
augroup vimrc
    autocmd!
augroup END

" }}}

" ==============================================================================
" plug Plugins {{{
" ==============================================================================
" set the runtime path to include plug and initialize
"set rtp+=~/.vim/aut/plug.vim
call plug#begin()
    Plug 'arzg/seoul8'
    Plug 'junegunn/limelight.vim'
    Plug 'junegunn/goyo.vim'
    Plug 'junegunn/fzf'
    Plug 'saltstack/salt-vim'
    Plug 'junegunn/fzf.vim'
    Plug 'junegunn/seoul256.vim'
    Plug 'morhetz/gruvbox'
    Plug 'junegunn/vim-easy-align'

    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'

    Plug 'tpope/vim-fugitive'
    Plug 'scrooloose/nerdtree'
    Plug 'ryanoasis/vim-devicons'
    Plug 'Xuyuanp/nerdtree-git-plugin'
    Plug 'sirver/ultisnips'
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
    Plug 'udalov/kotlin-vim'
    Plug 'airblade/vim-gitgutter'
    " All of your Plugins must be added before the following line
call plug#end()            " required
filetype plugin indent on    " required

" }}}

" ==============================================================================
" Plugin settings {{{
" ==============================================================================
" UltiSnips
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" NERDCommenter
"-----------------------------------------------
nmap ++ <Plug>NERDCommenterToggle
vmap ++ <Plug>NERDCommenterToggle

" NERDTree
"-----------------------------------------------
nnoremap <Leader>n :NERDTreeToggle<CR>

" function! IsNERDTreeOpen()        
"   return exists("t:NERDTreeBufName") && (bufwinnr(t:NERDTreeBufName) != -1)
" endfunction
" 
" function! SyncTree()
"   if &modifiable && IsNERDTreeOpen() && strlen(expand('%')) > 0 && !&diff
"     NERDTreeFind
"     wincmd p
"   endif
" endfunction
" 
" autocmd BufEnter * call SyncTree()

" GitGutter
" ----------------------------------------------
nmap ]h <Plug>(GitGutterNextHunk)
nmap [h <Plug>(GitGutterPrevHunk)

" airline
" ----------------------------------------------
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1 
let g:airline_theme = "base16"

" Coc
" ----------------------------------------------

" Create command for prettier
"command! -nargs=0 Prettier :CocCommand prettier.formatFile

" if hidden is not set, TextEdit might fail.
set hidden

" Some servers have issues with backup files, see #649
set nobackup
set nowritebackup

" Better display for messages
set cmdheight=2

" You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=300

" don't give |ins-completion-menu| messages.
set shortmess+=c

" always show signcolumns
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction
"
"" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()
"
"" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
"" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
"
"" Use `[c` and `]c` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)
"
" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

nmap <F2> <Plug>(coc-rename)

let g:coc_global_extensions = [
  \ 'coc-snippets',
  \ 'coc-pairs',
  \ 'coc-prettier',
  \ 'coc-json'
  \ ]

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Use <tab> for select selections ranges, needs server support, like: coc-tsserver, coc-python
nmap <silent> <TAB> <Plug>(coc-range-select)
xmap <silent> <TAB> <Plug>(coc-range-select)
xmap <silent> <S-TAB> <Plug>(coc-range-select-backword)

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" use `:OR` for organize import of current buffer
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add status line support, for integration with other plugin, checkout `:h coc-status`
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Using CocList
" Show all diagnostics
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

" Easy align
" ----------------------------------------------

" Allow alignment of % character
let g:easy_align_delimiters = { '%': {
            \ 'pattern': '%\+', 'delimiter_align': 'l', 'ignore_groups': ['!Comment']
            \ }, }

" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" Goyo
" ----------------------------------------------

let g:goyo_width = 68 " Leave a few extra chars more than textwidth

function! s:goyo_enter()   " On goyo enter:
    set noshowcmd            " Don't show last command
    set noshowmode           " Don't show current mode
    set scrolloff=999        " Centre current line
    Limelight                " Enable paragraph focus mode
    colo gruvbox            " Light colours
    set background=dark
    if has('gui_running')
        set fullscreen         " Enter fullscreen (don't use Mac native fullscreen for this)
        set linespace=7        " Extra leading is better for prose
    elseif exists('$TMUX')   " Hide tmux bar
        silent !tmux set status off
    endif
    let &l:statusline = '%M' " Show modified state on the bottom of the screen
    " This automatically disables on Goyo leave
    hi StatusLine
                \ ctermfg=137
                \ guifg=#be9873
                \ cterm=NONE
                \ gui=NONE
endfunction

function! s:goyo_leave() " On goyo exit:
    set showcmd            " Show last command
    set showmode           " Show current mode
    set scrolloff=1        " Always show one line of context around the cursor
    Limelight!             " Disable paragraph focus mode
    colo gruvbox          " Dark colours
    set background=dark
    if has('gui_running')
        set nofullscreen     " Exit fullscreen
        set linespace=3      " Standard leading
    elseif exists('$TMUX') " Enable tmux bar
        silent !tmux set status on
    endif
endfunction

" Activate respective function on goyo enter and leave
autocmd! vimrc User GoyoEnter nested call <sid>goyo_enter()
autocmd! vimrc User GoyoLeave nested call <sid>goyo_leave()

" Limelight
" ----------------------------------------------

let g:limelight_paragraph_span = 1  " Don't dim one par around the current one
let g:limelight_priority = -1 " Don't overrule hlsearch

" Fzf
" ----------------------------------------------
" This is the default extra key bindings
let g:fzf_action = {
            \ 'ctrl-t': 'tab split',
            \ 'ctrl-x': 'split',
            \ 'ctrl-v': 'vsplit' }

" Take colours from colour scheme
let g:fzf_colors =
            \ { 'fg':      ['fg', 'Normal'],
            \ 'bg':      ['bg', 'Normal'],
            \ 'hl':      ['fg', 'Comment'],
            \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
            \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
            \ 'hl+':     ['fg', 'Statement'],
            \ 'info':    ['fg', 'PreProc'],
            \ 'border':  ['fg', 'Ignore'],
            \ 'prompt':  ['fg', 'Conditional'],
            \ 'pointer': ['fg', 'Exception'],
            \ 'marker':  ['fg', 'Keyword'],
            \ 'spinner': ['fg', 'Label'],
            \ 'header':  ['fg', 'Comment'] }

" Hide statusline and mode indicator in fzf
autocmd vimrc FileType fzf set laststatus=0 noshowmode noruler
            \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler

let $FZF_DEFAULT_COMMAND = "find . -path '*/\.*' -type d -prune -o -type f -print -o -type l -print 2> /dev/null | sed s/^..//"

nnoremap <C-p> :FZF<CR>

" }}}

" ==============================================================================
" Bindings {{{
" ==============================================================================

" Comma
" ----------------------------------------------

" Juggling with buffers
" Comma, how you want to view the buffer, then b
" 'b' for buffer
nnoremap ,b :ls<CR>:buffer<Space>
nnoremap ,sb :ls<CR>:sbuffer<Space>
nnoremap ,vb :ls<CR>:vert sbuffer<Space>
nnoremap ,tb :tabnew<CR>:ls<CR>:buffer<Space>
nnoremap ,, :bnext<CR>

" Juggling with files
" Same for opening new files, just replace b with f (for recursive, just like
" :find) or e (for non-recursive, just like :edit)
" 'f' for find
" 'e' for edit
nnoremap ,f :find<Space>
nnoremap ,e :edit<Space>
nnoremap ,sf :sfind<Space>
nnoremap ,vf :vert sfind<Space>
nnoremap ,tf :tabfind<Space>
nnoremap ,se :split<Space>
nnoremap ,ve :vsplit<Space>
nnoremap ,te :tabnew<Space>

" Juggling with windows
" Same bindings for split/vsplit/tab as above, just double the letter *or* wait
" for the timeout
nnoremap ,s :split<CR>
nnoremap ,ss :split<CR>
nnoremap ,t :tabnew<CR>
nnoremap ,tt :tabnew<CR>
nnoremap ,v :vsplit<CR>
nnoremap ,vv :vsplit<CR>

" Project-wide search
" 'g' for grep
nnoremap ,g :Grep<Space>

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

" Enter distractioon-free mode using goyo
" 'w' for writing
nnoremap <Space>g :Goyo<CR>

" Toggle paragraph focus mode using limelight
" 'l' for limelight
nnoremap <Space>l :Limelight!!<CR>

" Redraw the screen
" 'r' for redraw
nnoremap <Space>r :redraw!<CR>

" Run the linter/compiler
" 'm' for make
nnoremap <Space>m :update<CR>:make<CR>

" Quick 'n' easy find-and-replace
nnoremap <Space><Space> :'{,'}s/\<<C-r>=expand("<cword>")<CR>\>/
nnoremap <Space>%       :%s/\<<C-r>=expand("<cword>")<CR>\>/

" }}}

" ==============================================================================
" General Settings {{{
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
set guifont="SauceCodePro Nerd Font Mono Bold":h16     " Use Menlo 14pt if running in MacVim
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
set timeoutlen=3000

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

" See README.md

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

set hlsearch   " Highlight search matches
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

" }}}

" ==============================================================================
" Statusline {{{
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

" }}}

" ==============================================================================
" Theming {{{
" ==============================================================================

set relativenumber
set number

set expandtab
set shiftwidth=2
set softtabstop=2
set tabstop=2
set foldenable

syntax on
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


" }}}