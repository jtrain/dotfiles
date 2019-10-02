set nocompatible
filetype off
set t_Co=256
let g:solarized_termcolors=256

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'

Plugin 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plugin 'junegunn/fzf.vim'
Plugin 'tpope/vim-unimpaired'
Plugin 'tpope/vim-fugitive'

Plugin 'python.vim'
Plugin 'pangloss/vim-javascript'
Plugin 'mxw/vim-jsx'
Plugin 'leafgarland/typescript-vim'

Plugin 'hynek/vim-python-pep8-indent'
Plugin 'plasticboy/vim-markdown'
Plugin 'w0rp/ale'
Plugin 'python/black'
Plugin 'ntpeters/vim-better-whitespace'
Plugin 'jtrain/django-tmux'
Plugin 'ervandew/screen'

"color schemes
Plugin 'altercation/vim-colors-solarized'

call vundle#end()
filetype plugin indent on

syntax on
set background=light
colorscheme solarized

set hidden

" allows better command line completion
set wildmenu

" show partial commands in last line of screen
set showcmd

" highlight search results
set hlsearch

" security benefit indeed
set nomodeline

" make benefit case insensitive searches, except if capitals used
set ignorecase
set smartcase

" turn on the ruler (show cursor position)
set ruler

" turn on line numbers
set number

" always display the status line, even if only one window is displayed
set laststatus=2

" instead of failing for no file save, ask for confirmation
set confirm

" allow backspacing over autoindent, line breaks and start of insert
set backspace=indent,eol,start

" use visual bell instead of beeping
set visualbell

" set command window height to two lines, to avoid
" having to press enter to continue
set cmdheight=2

" dont refresh screen during macro
set lazyredraw

" " INDENTATION SETTINGS

set shiftwidth=4
set softtabstop=4
set expandtab

let mapleader = ","

" 2 spaces for html/css/less etc
autocmd FileType html setlocal shiftwidth=2 softtabstop=2
autocmd FileType htmldjango setlocal shiftwidth=2 softtabstop=2
autocmd FileType mustache setlocal shiftwidth=2 softtabstop=2
autocmd FileType css setlocal shiftwidth=2 softtabstop=2
autocmd FileType less setlocal shiftwidth=2 softtabstop=2
autocmd FileType yaml setlocal shiftwidth=2 softtabstop=2

" <esc> really chaps my sack
inoremap jk <esc>

" accept C-6 for buffer switch
noremap <C-6> gj

" set up soft word wrapping
set formatoptions=1
set linebreak

" set up visual line jumps
nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk

" markdown
let g:vim_markdown_folding_disabled = 1

" django html
au BufRead,BufNewFile *.html set filetype=htmldjango
au BufRead,BufNewFile *.mustache set filetype=htmldjango

" use fzf
map <C-p> :GFiles<CR>

" django tmux
let g:tmux_djangotest_manage_py="python manage.py"
let g:tmux_djangotest_file_prefix="source bin/activate &&"
let g:tmux_djangotest_test_cmd="test --keepdb"

let g:ScreenImpl="Tmux"
let g:ScreenShellTmuxInitArgs = '-2'
let g:ScreenShellQuitOnVimExit = 1
map <Leader>q :ScreenQuit<CR>

noremap <C-b> :Python2or3 run_django_test()<CR>
" Statusline
set statusline=
set statusline=%f
set statusline+=%M
set statusline+=%r
set statusline+=%h
set statusline+=%=
set statusline+=%c,
set statusline+=%l
set statusline+=\ %p%%

" Ale
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)

let g:ale_lint_on_text_changed = 'never'

"Use locally installed flow
let local_flow = finddir('node_modules', '*/**') . '/.bin/flow'
if matchstr(local_flow, "^\/\\w") == ''
    let local_flow= getcwd() . "/" . local_flow
endif
if executable(local_flow)
    let g:ale_javascript_flow_executable = local_flow
endif

" for webpack
autocmd FileType javascript.jsx,javascript set backupcopy=yes

" Black autosave
autocmd BufWritePre *.py execute ':Black'

let g:ale_linters = {
\   'javascript': ['eslint', 'flow', 'flow-language-server'],
\   'javascript.jsx': ['eslint', 'flow', 'flow-language-server'],
\}
