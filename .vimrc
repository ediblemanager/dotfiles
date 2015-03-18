" For the below config, see here:
" http://amix.dk/vim/vimrc.html

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Sets how many lines of history VIM has to remember
set history=1700

" Enable filetype plugins
filetype on
filetype plugin on
filetype indent on

" Add Pathogen support for management of assets
execute pathogen#infect()

" Set to auto read when a file is changed from the outside
set autoread

" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
let mapleader = ","
let g:mapleader = ","

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => VIM user interface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Set 7 lines to the cursor - when moving vertically using j/k
set so=7

" Turn on the WiLd menu
set wildmenu

" Ignore compiled files
set wildignore=*.o,*~,*.pyc

"Always show current position
set ruler

" Height of the command bar
set cmdheight=2

" Configure backspace so it acts as it should act
set backspace=2
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

" Ignore case when searching
set ignorecase

" When searching try to be smart about cases
set smartcase

" Highlight search results
set hlsearch

" Show matching brackets when text indicator is over them
set showmatch

" How many tenths of a second to blink when matching brackets
set mat=2

" No annoying sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors and Fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Enable syntax highlighting
syntax enable

set t_Co=256
highlight Normal ctermfg=grey ctermbg=black
colorscheme mustang

" Set extra options when running in GUI mode
if has("gui_running")
    set guioptions-=T
    set guioptions+=e
    set t_Co=256
    set guitablabel=%M\ %t
    set guioptions+=Lrb
    set guioptions-=Lrb
endif

" Set utf8 as standard encoding and en_US as the standard language
set encoding=utf8

" Use UNIX as the standard file type
set ffs=unix,dos,mac

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text, tab and indent related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Use spaces instead of tabs
set expandtab

" Be smart when using tabs ;)
set smarttab

" 1 tab == 4 spaces
set shiftwidth=4
set tabstop=4
set softtabstop=4
set cindent

" Linebreak on 500 characters
set lbr
set tw=500

set ai "Auto indent
set si "Smart indent
set wrap "Wrap lines

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Moving around, tabs, windows and buffers
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Return to last edit position when opening files (You want this!)
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif
" Remember info about open buffers on close
set viminfo^=%

"Bubble single lines (kicks butt)
""http://vimcasts.org/episodes/bubbling-text/
nmap <C-j> ddp
nmap <C-k> ddkP

""""""""""""""""""""""""""""""
" => Status line
""""""""""""""""""""""""""""""

" Always show the status line
set laststatus=2

" Format the status line
set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ \ CWD:\ %r%{getcwd()}%h\ \ \ Line:\ %l

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Spell checking
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Pressing ,ss will toggle and untoggle spell checking
map <leader>ss :setlocal spell!<cr>

" Set region to British English
set spelllang=en_gb

" Set spellchecking in git commit messages
au BufNewFile,BufRead COMMIT_EDITMSG setlocal spell

" Add spellchecking by default
map <F5> :setlocal spell! spelllang=en_gb<CR>

" Shortcuts using <leader>
map <leader>sn ]s
map <leader>sp [s
map <leader>sa zg
map <leader>s? z=


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Temporary Files
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set backupdir=~/.vim/tmpdir
set directory=~/.vim/tmpdir

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Helper functions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Returns true if paste mode is enabled
function! HasPaste()
    if &paste
        return 'PASTE MODE  '
    en
    return ''
endfunction


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Previous (non-website) config
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set nocompatible
set number
set scrolloff=3

"Set undo'ing
set undodir=~/.vim/undodir
set undofile
set undolevels=1000
set undoreload=10000

"copy and paste to x
map ppp "*p
map yyy "*y

"Speed up buffer switching
map <C-Up> <C-W>k
map <C-Down> <C-W>j
map <C-Left> <C-W>h
map <C-Right> <C-W>l
map <Tab> :tabnext <Enter>
map <S-Tab> :tabprev <CR>

"Speed up buffer resizing
map + <C-W>+
map - <C-W>-

"Add reviewed by tag
:map <F7> oReviewed-by: Gordon Thomson <gt43@st-andrews.ac.uk><Esc>
"Add tested by tag - 1.8
:map <F8> oTested-by: Gordon Thomson <gt43@st-andrews.ac.uk> [Ubuntu 13.10]<Esc>
"Add signed off by tag
:map <F9> oSigned-off-by: Gordon Thomson <gordon@st-andrews.ac.uk><Esc>

"Shortcut to rapidly toggle `set list` which shows hidden chars
nmap <leader>l :set list!<CR>

"Use the same symbols as TextMate for tabstops and EOLs
set listchars=tab:?\ ,eol:¬

"Enable mouse usage
set ttymouse=xterm
set mouse=r

"Set PHP file indentation characteristics
au BufRead,BufNewFile *.html,*.php set filetype=php
autocmd FileType php set expandtab
autocmd FileType php set tabstop=4
autocmd FileType php set shiftwidth=4
autocmd FileType php set autoindent
autocmd FileType php set smartindent
" The line below adds closing braces when opening braces are typed, and moves the cursor to the next line (with indent).
"autocmd FileType php inoremap { {<CR>}<up><end><CR>

"Ruby-specific stuff here
autocmd BufNewFile,BufRead *.feature,*.story  set filetype=cucumber

au BufRead,BufNewFile *.rhtml,*.rb set filetype=ruby
autocmd FileType ruby set tabstop=2
autocmd FileType ruby set shiftwidth=2
autocmd FileType ruby set expandtab
autocmd FileType ruby set softtabstop=2

autocmd FileType cucumber set tabstop=2
autocmd FileType cucumber set shiftwidth=2
autocmd FileType cucumber set expandtab
autocmd FileType cucumber set softtabstop=2

"Git commit messages
autocmd FileType gitcommit call setpos('.', [0, 1, 1, 0])

" Highlight extra whitespace in files
highlight ExtraWhitespace ctermbg=darkgreen guibg=darkgreen
match ExtraWhitespace /\s\+$/

"Strip Trailing Whitespace
function! <SID>StripTrailingWhitespaces()
    " Preparation: save last search, and cursor position.
    let _s=@/
    let l = line(".")
    let c = col(".")
    " Do the business:
    %s/\s\+$//e
    " Clean up: restore previous search history, and cursor position
    let @/=_s
    call cursor(l, c)
endfunction

autocmd BufWritePre * :call <SID>StripTrailingWhitespaces()

"Smarty support
au BufRead,BufNewFile *.tpl set filetype=smarty

"ASP formatting
autocmd BufNewFile,BufRead *.asp set ft=aspvbs

" Blade support
autocmd BufNewFile,BufRead *.blade.php set ft=blade.html.php

"Abbreviations
ab US United States
ab helpers Helpers
ab dh displayHelpers::debugData(
ab Heleprs Helpers


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Shell Interaction
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

autocmd BufEnter * let &titlestring = ' ' . expand("%:t")
set title

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Add JS handling functions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let javascript_enable_domhtmlcss=1


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Add binding for testing
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nmap ,t :!phpunit<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Add binding for syntax checking
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nmap ,. :w !php -l<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Powerline Config
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:airline_powerline_fonts = 1
if !exists('g:airline_symbols')
      let g:airline_symbols = {}
endif
let g:airline_symbols.space = "\ua0"
set linespace=0
