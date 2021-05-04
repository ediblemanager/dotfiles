"set runtimepath^=~/.vim runtimepath+=~/.vim/after
"let &packpath = &runtimepath
"source ~/.vimrc

call plug#begin('~/.vim/plugged')

"Plug 'myusuf3/numbers.vim'
""Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
""Plug 'junegunn/fzf.vim'
"
"" Tags
"Plug 'ludovicchabant/vim-gutentags'
"
"" NERDTree
"Plug 'scrooloose/nerdtree'
"
"" Git integration
"Plug 'tpope/vim-fugitive'
"Plug 'airblade/vim-gitgutter'
"
"" Linting
""Plug 'neomake/neomake'
"Plug 'w0rp/ale'
"
"" PHP-specific integration
"Plug 'phpactor/phpactor' ,  {'do': 'composer install', 'for': 'php'}
"Plug 'ncm2/ncm2'
"Plug 'roxma/nvim-yarp'
""Plug 'phpactor/ncm2-phpactor'
""Plug 'jwalton512/vim-blade'
"if has('nvim')
"  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
"else
"  Plug 'Shougo/deoplete.nvim'
"  Plug 'roxma/nvim-yarp'
"  Plug 'roxma/vim-hug-neovim-rpc'
"endif
"
"let g:deoplete#ignore_sources = get(g:, 'deoplete#ignore_sources', {})
"let g:deoplete#ignore_sources.php = ['omni']
"
"" Snippets
"Plug 'SirVer/ultisnips'
"Plug 'honza/vim-snippets'
"
"" Comments
""Plug 'tpope/vim-commentary'
"
"" Search
""Plug '~/.fzf'
""Plug 'junegunn/fzf.vim'
"
"" Better PHP syntax
""Plug 'StanAngeloff/php.vim'
"Plug 'sheerun/vim-polyglot'
"
"Plug 'vim-airline/vim-airline'
"
"" Git blame
"Plug 'zivyangll/git-blame.vim'
"
"" Colorschemes
"Plug 'rafi/awesome-vim-colorschemes'
"Plug 'croaker/mustang-vim'
"
"" Formatting
""Plug 'sbdchd/neoformat'
""Plug 'prettier/vim-prettier', { 'do': 'yarn install' }
"
"" UI things
"Plug 'ryanoasis/vim-devicons'
"Plug 'posva/vim-vue'
""Behave a bit more Gui-ey
"Plug 'wincent/terminus'

" NEW CONFIG AS OF AUGUST 2019
Plug '2072/PHP-Indenting-for-VIm'    " PHP indent script
Plug 'Yggdroot/indentLine'           " highlighting 4sp indenting
Plug 'chrisbra/Colorizer'            " colorize colors
Plug 'chriskempson/base16-vim'       " high quality colorschemes
Plug 'mhinz/vim-signify'             " show VCS changes
Plug 'sheerun/vim-polyglot'          " newer language support
Plug 'dense-analysis/ale'                      " realtime linting
Plug 'vim-airline/vim-airline'
Plug 'prettier/vim-prettier', { 'do': 'yarn install' }

" Code Analysis and Completion
"Plug 'lvht/phpcd.vim', { 'for': 'php', 'do': 'composer install' }
Plug 'ternjs/tern_for_vim', { 'do': 'npm install' }
if has('nvim')
" Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' } "async completion
  Plug 'roxma/vim-hug-neovim-rpc'
else
" Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif

" Other Features
Plug 'mileszs/ack.vim'               " ack/rg support
Plug 'mattn/emmet-vim'               " emmet support
Plug 'editorconfig/editorconfig-vim' " editorconfig support
Plug 'scrooloose/nerdtree'           " sidebar for browsing files
Plug 'croaker/mustang-vim'

" UI things
Plug 'ryanoasis/vim-devicons'
Plug 'posva/vim-vue'
"Behave a bit more Gui-ey
Plug 'wincent/terminus'
" Syntax
Plug 'StanAngeloff/php.vim'

call plug#end()

" NEW SETTINGS AS OF AUGUST 2019
" leader
let mapleader="\<SPACE>"
"set spell
set number list "lazyredraw
set fillchars=vert:\ ,fold:\  listchars=tab:⎸\ ,nbsp:⎕
set linebreak showbreak=↪\  breakindent breakindentopt=shift:-2
set formatoptions+=nj
let g:PHP_outdentphpescape = 0

" DEOPLETE
"let g:deoplete#enable_at_startup = 1
"let g:deoplete#enable_yarp = 1
"let g:deoplete#ignore_sources = get(g:, 'deoplete#ignore_sources', {})
"let g:deoplete#ignore_sources.php = ['omni']
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"
inoremap <expr><s-tab> pumvisible() ? "\<c-p>" : "\<s-tab>"
autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif

" ALE
" PHP linting
"let g:ale_php_phpcs_executable='./phpcs'
"let g:ale_php_php_cs_fixer_executable='./php-cs-fixer'
" If I don't do this, phpcbf fails on any file in the exclude-pattern :/
let g:ale_php_phpcbf_executable = $HOME.'/.support/phpcbf-helper.sh'
" in order to get the alternate executable working you have to declare it as
" use global, even though it's not 'global' :/
let g:ale_php_phpcbf_use_global = 1

" number of spaces per indentation level
" Prettier default: 2
let g:prettier#config#tab_width = 4

" Run both javascript and vue linters for vue files.
let g:ale_linters = {
\   'javascript': ['eslint', 'prettier'],
\   'vue': ['prettier'],
\   'css': ['prettier'],
\   'html': ['prettier'],
\   'php': ['phpcs'],
\}

"let g:ale_open_list = 1

"let g:ale_linter_aliases = ['javascript', 'vue']
"
"
" disable linting while typing
let g:ale_lint_on_text_changed = 'never'
" lint only on save
let g:ale_lint_on_enter = 0
let g:ale_lint_on_save = 1
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
let g:ale_open_list = 1
let g:ale_keep_list_window_open=0
let g:ale_set_quickfix=0
let g:ale_list_window_size = 5
let g:ale_php_phpcbf_standard='PSR2'
let g:ale_php_phpcs_standard='phpcs.xml.dist'
let g:ale_php_phpmd_ruleset='phpmd.xml'

" Only run linters we want to run.
let g:ale_linters_explicit = 1

" Fixer config
let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'javascript': ['eslint', 'prettier'],
\   'vue': ['eslint', 'prettier'],
\   'css': ['prettier'],
\   'html': ['prettier'],
\   'php': ['phpcbf', 'php_cs_fixer', 'remove_trailing_lines', 'trim_whitespace'],
\}

let g:ale_fix_on_save = 1

let g:ale_sign_column_always = 1

let g:ale_sign_error = '✘'
let g:ale_sign_warning = '⚠'
"highlight ALEErrorSign ctermbg=NONE ctermfg=red
"highlight ALEWarningSign ctermbg=NONE ctermfg=yellow
"let g:ale_sign_error = '⚑'
"let g:ale_sign_warning = '⚐'
"let g:ale_set_balloons = 1


let g:airline#extensions#ale#enabled = 1
" Bind F8 to fixing problems with ALE
nmap <silent> <leader>fp <Plug>(ale_fix)
" Jump to errors
nmap <silent> <leader>pe <Plug>(ale_previous_wrap)
nmap <silent> <leader>ne <Plug>(ale_next_wrap)

" OSX stupid backspace fix
set backspace=indent,eol,start

" change colors for matching parenthesis
let g:rainbow_active = 1

" indentLine
let g:indentLine_char = "│"

" Polyglot
let g:vim_markdown_conceal = 0

" Nerdtree will be open if vim is called on its own
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
let NERDTreeShowHidden=1

" Ctrl+n to open nerdtree
map <C-n> :NERDTreeToggle<CR>

"Completion
"let g:deoplete#enable_at_startup = 1
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

" Pretty formatting of files

" Vue syntax
"autocmd BufRead,BufNewFile *.vue setlocal filetype=vue
"let g:vim_vue_plugin_load_full_syntax = 1
"let g:vim_vue_plugin_debug = 1

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

"Cursor
set nocursorline

"Redraw
set nolazyredraw


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
au BufRead,BufNewFile *.html,*.php set filetype=php.html
autocmd FileType php set expandtab
autocmd FileType php set tabstop=4
autocmd FileType php set shiftwidth=4
autocmd FileType php set autoindent
autocmd FileType php set smartindent

" Only for php files
"autocmd BufWritePre *.php :normal magg=G`a

" Blade support
autocmd BufNewFile,BufRead *.blade.php set ft=blade.html.php

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
