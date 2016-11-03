set nocompatible
filetype off
set t_Co=256
let g:solarized_termcolors=256

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'

Plugin 'kien/ctrlp.vim'
Plugin 'python.vim'

Plugin 'hynek/vim-python-pep8-indent'
Plugin 'plasticboy/vim-markdown'
Plugin 'scrooloose/syntastic'
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

" " INDENTATION SETTINGS

set shiftwidth=4
set softtabstop=4
set expandtab

" 2 spaces for html/css/less etc
autocmd FileType html setlocal shiftwidth=2 softtabstop=2
autocmd FileType htmldjango setlocal shiftwidth=2 softtabstop=2
autocmd FileType mustache setlocal shiftwidth=2 softtabstop=2
autocmd FileType css setlocal shiftwidth=2 softtabstop=2
autocmd FileType less setlocal shiftwidth=2 softtabstop=2
autocmd FileType yaml setlocal shiftwidth=2 softtabstop=2

" <esc> really chaps my sack
inoremap jk <esc>

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

" stop ctrlp.vim opening certain files
"set wildignore+=*/tmp/*,*.so,*.o,*.lo,*.swp,*.zip,*.pyc
let g:ctrlp_max_files = 0
let g:ctrlp_user_command = {
  \ 'types': {
    \ 1: ['.git', 'cd %s && git ls-files --cached --exclude-standard --others'],
    \ 2: ['.hg', 'hg --cwd %s locate -I .'],
    \ },
  \ 'fallback': 'find %s -type f'
  \ }

" django tmux
let g:tmux_djangotest_manage_py="python manage.py"
let g:tmux_djangotest_file_prefix="source bin/activate &&"
let g:tmux_djangotest_test_cmd="test --keepdb"

let g:ScreenImpl="Tmux"
let g:ScreenShellTmuxInitArgs = '-2'
let g:ScreenShellQuitOnVimExit = 1
map <Leader>q :ScreenQuit<CR>

noremap <C-b> :python run_django_test()<CR>
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

" Syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_enable_signs = 1
let g:syntastic_python_flake8_args = "--max-complexity 10"
