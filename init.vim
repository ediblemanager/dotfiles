"set runtimepath^=~/.vim runtimepath+=~/.vim/after
"let &packpath = &runtimepath
"source ~/.vimrc

call plug#begin('~/.vim/plugged')

Plug 'myusuf3/numbers.vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" Tags
Plug 'ludovicchabant/vim-gutentags'

" NERDTree
Plug 'scrooloose/nerdtree'

" Git integration
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

" Linting
"Plug 'neomake/neomake'
"Plug 'w0rp/ale'

" PHP-specific integration
Plug 'phpactor/phpactor' ,  {'do': 'composer install', 'for': 'php'}
Plug 'ncm2/ncm2'
Plug 'roxma/nvim-yarp'
"Plug 'phpactor/ncm2-phpactor'
Plug 'jwalton512/vim-blade'
if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif

" Snippets
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

" Comments
"Plug 'tpope/vim-commentary'

" Search
"Plug '~/.fzf'
"Plug 'junegunn/fzf.vim'

" Better PHP syntax
"Plug 'StanAngeloff/php.vim'

Plug 'vim-airline/vim-airline'

" Git blame
Plug 'zivyangll/git-blame.vim'

" Colorschemes
Plug 'rafi/awesome-vim-colorschemes'
Plug 'croaker/mustang-vim'

" Formatting
Plug 'sbdchd/neoformat'

" UI things
Plug 'ryanoasis/vim-devicons'

call plug#end()

" Set font
set encoding=utf8
set guifont=Fira\ Code:h12

" Nerdtree will be open if vim is called on its own
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

" Ctrl+n to open nerdtree
map <C-n> :NERDTreeToggle<CR>

"Completion
let g:deoplete#enable_at_startup = 1
"autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
"set ofu=syntaxcomplete#Complete
"autocmd BufEnter * call ncm2#enable_for_buffer()
"set completeopt=noinsert,menuone,noselect
"autocmd FileType php setlocal omnifunc=phpactor#Complete,syntaxcomplete#Complete
"let g:phpactorOmniError = v:true

" FZF
let $FZF_DEFAULT_COMMAND = 'ag --skip-vcs-ignores -g ""'
let g:fzf_filemru_bufwrite = 1
let g:fzf_filemru_git_ls = 1
let g:fzf_filemru_ignore_submodule = 1

" prevent gutentags from indexing the entire home directory
" https://github.com/ludovicchabant/vim-gutentags/issues/13
let s:notags = expand('~/.notags')
if !filereadable(s:notags)
    call writefile([], s:notags)
endif

set tags=./.tags,.tags
let g:gutentags_ctags_tagfile = 'tags'
let g:gutentags_file_list_command = { 'markers': { '.git': 'git ls-files', }, }
let g:gutentags_generate_on_new = 1

"General
syntax on
"colorscheme mustang
colorscheme mustang
highlight Normal ctermfg=grey ctermbg=black
set nu
filetype plugin indent on
set nocp
set ruler
set wildmenu
set mouse-=a
set t_Co=256

"Code folding
set foldmethod=manual

"Tabs and spacing
set autoindent
set cindent
set tabstop=4
set expandtab
set shiftwidth=4
set smarttab

"Search
set hlsearch
set incsearch
set ignorecase
set smartcase
set diffopt +=iwhite

"Syntax highlighting in Markdown
"au BufNewFile,BufReadPost *.md set filetype=markdown
"let g:markdown_fenced_languages = ['bash=sh', 'css', 'django', 'javascript', 'js=javascript', 'json=javascript', 'perl', 'php', 'python', 'ruby', 'sass', 'xml', 'html', 'vim']

" Neomake config
" Full config: when writing or reading a buffer, and on changes in insert and
" normal mode (after 1s; no delay when writing).
"call neomake#configure#automake('nrwi', 500)

" Git blame
nmap <Leader>s :<C-u>call gitblame#echo()<CR>

" PHPActor config
" Include use statement
nmap <Leader>u :call phpactor#UseAdd()<CR>

" Invoke the context menu
nmap <Leader>mm :call phpactor#ContextMenu()<CR>

" Invoke the navigation menu
nmap <Leader>nn :call phpactor#Navigate()<CR>

" Goto definition of class or class member under the cursor
nmap <Leader>o :call phpactor#GotoDefinition()<CR>

" Transform the classes in the current file
nmap <Leader>tt :call phpactor#Transform()<CR>

" Generate a new class (replacing the current file)
nmap <Leader>cc :call phpactor#ClassNew()<CR>

" Extract expression (normal mode)
nmap <silent><Leader>ee :call phpactor#ExtractExpression(v:false)<CR>

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


"Set undo'ing
set undodir=~/.config/nvim/undodir
set undofile
set undolevels=1000
set undoreload=10000

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Easy exit from insert mode
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
imap jj <esc>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Quick save from insert mode
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
imap ww <esc>:w<CR>

" Extract expression from selection
vmap <silent><Leader>ee :<C-U>call phpactor#ExtractExpression(v:true)<CR>

" Extract method from selection
vmap <silent><Leader>em :<C-U>call phpactor#ExtractMethod()<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Powerline Config
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:airline_powerline_fonts = 1
if !exists('g:airline_symbols')
      let g:airline_symbols = {}
endif
let g:airline_symbols.space = "\ua0"
set linespace=0

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Add binding for syntax checking
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nmap ,. :w !php -l<cr>
nmap <F3> :w !php -l<CR>

"Abbreviations
ab US United States
ab helpers Helpers
ab dh displayHelpers::debugData(
ab slq displayHelpers::showLastQuery($capsule, true);
ab Heleprs Helpers

"Set PHP file indentation characteristics
au BufRead,BufNewFile *.html,*.php set filetype=php
autocmd FileType php set expandtab
autocmd FileType php set tabstop=4
autocmd FileType php set shiftwidth=4
autocmd FileType php set autoindent
autocmd FileType php set smartindent

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

" Blade support
autocmd BufNewFile,BufRead *.blade.php set ft=blade.html.php
